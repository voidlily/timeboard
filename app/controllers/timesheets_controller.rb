class TimesheetsController < ApplicationController
  before_filter RubyCAS::Filter
  before_filter :check_for_user_in_db
  before_filter :get_current_user

  def index
    @title = "Timesheets"
    @user = User.find_by_account(session[:cas_user])
    # Here we will generate a proper listing that should be default per user.  
    # For students, this goes to all drafts or disapproved timesheets
    # For professors, this goes to all signed timesheets
    # For finance, this goes to approved timesheets.
    @timesheet_list = @user.timesheets
    if @user.type == 'Student'
      if params[:status].nil? || params[:status] == "Open"
	@timesheet_list = @timesheet_list.select{|timesheet| timesheet.status == "Draft" || timesheet.status == "Disapproved"}
      else
	logger.debug "Timesheet List: #{@timesheet_list}"
	@requested_status = params[:status]
	@timesheet_list = @timesheet_list.select{|timesheet| timesheet.status == @requested_status}
      end
    elsif @user.type == 'Professor'
      @requested_status = params[:status].nil? ? "Signed" : params[:status]
      if @requested_status == "Open"
	@timesheet_list = @timesheet_list.select{|timesheet| timesheet.status == "Draft" || timesheet.status == "Disapproved"}
      else  
	@timesheet_list = @timesheet_list.select{|timesheet| timesheet.status == @requested_status}
      end
    elsif @user.type == 'Finance'
      @requested_status = params[:status].nil? ? "Approved" : params[:status]
      if @requested_status == "Open"
	@timesheet_list = @timesheet_list.select{|timesheet| timesheet.status == "Draft" || timesheet.status == "Disapproved"}
      else  
	@timesheet_list = @timesheet_list.select{|timesheet| timesheet.status == @requested_status}
      end

    end
  end

  def show
    @user = User.find_by_account(session[:cas_user])
    begin
      temp_timesheet = Timesheet.find(params[:id])
    rescue
      flash[:error] = "No timesheet with this id exists"
      redirect_to timesheets_path
      return
    end
    if (temp_timesheet.student.account == session[:cas_user])
      @timesheet = temp_timesheet
      @user = temp_timesheet.student
      @title = "Edit Timesheet"
      if @timesheet.status == "Disapproved"
	flash[:notice] = 'Reopen Reason: ' + @timesheet.reopen_reason
      end
    elsif (@user.type == 'Professor')
      @timesheet = temp_timesheet
      @student = temp_timesheet.student
      @title = "Approve Timesheet"
      if @user.students.index(@student).nil?
	flash[:error] = "You cannot view this timesheet"
	redirect_to timesheets_path
	return
      end
    elsif (@user.type == 'Finance')
      @timesheet = temp_timesheet
      @student= temp_timesheet.student
      @title = "Process Timesheet"
    elsif (@user.type == 'Student')
      flash[:error] = "You do not have permission to view that timesheet"
      redirect_to timesheets_path
    end
    
  end

  def new
    #TODO what to do here?
    #TODO current_user
    #@timesheet = Timesheet.new(:user => current_user)
  end

  def edit
    #TODO what?
  end

  def create
    #TODO: depends on frontend
  end

  def update
    #TODO: depends on frontend
    if params[:commit] == "Sign" || params[:commit] == "Approve" || params[:commit] == "Process"
      sign
      return
    end
    @user = User.find_by_account(session[:cas_user])
    temp_timesheet = Timesheet.find(params[:id])
    if params[:commit] == "Disapprove" && @user.type == "Professor"
      disapprove(params)
      return
    end
    if(User.find_by_account(session[:cas_user]).type == "Professor")
      approve
      return
    end
    error_occurred = false
    if (temp_timesheet.student.account == session[:cas_user])
      @timesheet = temp_timesheet
      input_entry_changes = params[:timesheet][:timesheet_entries_attributes]
      holidays = Holiday.all
      @timesheet.timesheet_entries.each do |tse|
      	change = input_entry_changes[tse.id.to_s]
      	if change
      	  tse.hours = change[:hours]
	  tse.hours = tse.hours.round(2) #Round to nearest 2 decimal places.
	  isHoliday = false
	  holidays.each do |h|
	    isHoliday = (h.date == tse.date)
	  end
          if (isHoliday && tse.hours != 0)
	    flash[:error] = "You cannot save changes to a holiday"
	    redirect_to @timesheet
	    return
	  end
      	  error_occurred |= !tse.save
      	else
      	  flash[:error] = "Error Occurred." 
      	  redirect_to @timesheet
      	  return
      	end
      end
      
      if (!error_occurred)
      	flash[:notice] = "Timesheet was successfully saved"
	@timesheet.draft!
	@timesheet.save
      	redirect_to @timesheet
      else
        flash[:error] = "Some errors occurred, check over timesheet and save again"
      	redirect_to @timesheet
      end
    end
  end
  
  private

  def approve
    professor = User.find_by_account(session[:cas_user])
    timesheets = professor.timesheets.select{|timesheet| timesheet.status == "Signed"}
    timesheets.each do |timesheet|
      if(params[timesheet.id.to_s]=="Approved")
        timesheet.approve!
      end
    end
    flash[:notice] = "Timesheets approved."
    redirect_to timesheets_path
  end

  def sign
    student = User.find_by_account(session[:cas_user])
    @timesheet = Timesheet.find(params[:id])
    if student.timesheets.include?(@timesheet)
      if student.type == "Professor"
        @timesheet.approve!
        flash[:notice] = "Timesheet has been approved."
      elsif student.type == "Student"
        @timesheet.sign!
        flash[:notice] = "Timesheet has been signed."
      elsif student.type == "Finance"
        @timesheet.process!
        flash[:notice] = "Timesheet has been processed"
        redirect_to timesheets_path(:status => "Approved")
        return
      end
    end
    redirect_to @timesheet
    
  end

  def disapprove(params)
    if params[:timesheet][:reopen_reason] == ""
      flash[:error] = "You must add a comment in order to disapprove"
      redirect_to Timesheet.find(params[:id])
      return
    end
    ts = Timesheet.find(params[:id])
    professor = User.find_by_account(session[:cas_user])
    if professor.timesheets.include?(ts)
      ts.reopen(params[:timesheet][:reopen_reason])
    end
    flash[:notice] = "Timesheet has been disapproved"
    redirect_to timesheets_path(:status => "Signed")
    
  end

  def check_for_user_in_db
    if(User.find_by_account(session[:cas_user]).nil?)
      flash[:error] = "User not found in Timeboard database."
      redirect_to root_path
    end
  end

  def get_current_user
    @current_user = User.find_by_account(session[:cas_user])
  end

end
