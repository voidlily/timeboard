class TimesheetsController < ApplicationController
  before_filter RubyCAS::Filter
  before_filter :check_for_user_in_db

  def index
    @title = "Timesheets"
    @user = User.find_by_account(session[:cas_user])
    @timesheet_list = @user.timesheets
    #TODO define current_user
    #blocked by cas implementation for sessions controller
    #@timesheets = current_user.timesheets
  end

  def show
    #TODO probably vulnerable to direct reference
    temp_timesheet = Timesheet.find(params[:id])
    if (temp_timesheet.student.account == session[:cas_user])
      @timesheet = temp_timesheet
      @user = temp_timesheet.student
    end
    @title = "Edit Timesheet"
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
    temp_timesheet = Timesheet.find(params[:id])
    if (temp_timesheet.student.account == session[:cas_user])
      @timesheet = temp_timesheet
      if(@timesheet.update_attributes(params[:timesheet]))
        redirect_to @timesheet
      else
        render 'show'
      end
    end

  end

  #TODO sign? approve? how to make it RESTful?
  private

  def check_for_user_in_db
    if(User.find_by_account(session[:cas_user]).nil?)
      redirect_to root_path
    end
  end
end
