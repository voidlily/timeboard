class TimesheetsController < ApplicationController
  def index
    @title = "Timesheets"
    #TODO define current_user
    #blocked by cas implementation for sessions controller
    #@timesheets = current_user.timesheets
  end

  def show
    #TODO probably vulnerable to direct reference
    @timesheet = User.find(params[:id])
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
  end

  #TODO sign? approve? how to make it RESTful?

end
