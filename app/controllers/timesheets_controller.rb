class TimesheetsController < ApplicationController
  before_filter RubyCAS::Filter
  before_filter :check_for_user_in_db

  def index
    @title = "Timesheets"
    @user = User.find_by_account(session[:cas_user])
    @timesheet_list = @user.timesheets
    @requested_status = params[:status].nil? ? "Signed" : params[:status]
    @timesheet_list = @timesheet_list.select{|timesheet| timesheet.status == @requested_status}
    #TODO define current_user
    #blocked by cas implementation for sessions controller
    #@timesheets = current_user.timesheets
  end

  def show
    #TODO probably vulnerable to direct reference
    @user = User.find_by_account(session[:cas_user])
    temp_timesheet = Timesheet.find(params[:id])
    if (temp_timesheet.student.account == session[:cas_user])
      @timesheet = temp_timesheet
      @user = temp_timesheet.student
      @title = "Edit Timesheet"
    elsif (@user.type == 'Professor')
      @timesheet = temp_timesheet
      @student = temp_timesheet.student
      @title = "Approve Timesheet"
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
    if params[:commit] == "Sign" || params[:commit] == "Approve"
      sign
      return
    end
    @user = User.find_by_account(session[:cas_user])
    temp_timesheet = Timesheet.find(params[:id])
    if(User.find_by_account(session[:cas_user]).type == "Professor")
      approve
    end
    bol = true
    if (temp_timesheet.student.account == session[:cas_user])
      @timesheet = temp_timesheet
      input_entry_changes = params[:timesheet][:timesheet_entries_attributes]
      @timesheet.timesheet_entries.each do |tse|
	change = input_entry_changes[tse.id.to_s]
	if change
	  tse.hours = change[:hours]
	  bol = tse.save
	else
	  flash[:notice] = "Error Occurred." 
	  redirect_to @timesheet
	  return
	end
      end
      if (bol)
	redirect_to @timesheet
      else
	redirect_to @timesheet
      end
    end

  end
  
  
  #TODO sign? approve? how to make it RESTful?
  private

  def approve
    professor = User.find_by_account(session[:cas_user])
    timesheets = professor.timesheets.select{|timesheet| timesheet.status == "Signed"}
    timesheets.each do |timesheet|
      if(params[timesheet.id.to_s]=="Approved")
        timesheet.approve!
      end
    end
    redirect_to timesheets_path
  end

  def sign
    student = User.find_by_account(session[:cas_user])
    @timesheet = Timesheet.find(params[:id])
    if student.type == "Professor"
      @timesheet.approve!
      flash[:notice] = "Timesheet has been approved."
    elsif student.type == "Student"
      @timesheet.sign!
      flash[:notice] = "Timesheet has been signed."
    end
    redirect_to @timesheet
    
  end

  def check_for_user_in_db
    if(User.find_by_account(session[:cas_user]).nil?)
      flash[:error] = "User not found in Timeboard database."
      redirect_to root_path
    end
  end
end
