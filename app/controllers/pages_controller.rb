class PagesController < ApplicationController
  before_filter RubyCAS::Filter, :only => :login
  before_filter :check_for_user_in_db

  def home
  end

  def login
    #Redirects users to appropriate paths
    user = User.find_by_account(session[:cas_user])
    if (user.nil?)
      redirect_to root_path
      return
    end
    if user.type == "Student"
      #TODO make this go to current timesheet.
      if (user.current_timesheet == nil)
	redirect_to timesheets_path(:status => "Drafts")
      else
	redirect_to user.current_timesheet
      end
    elsif user.type == "Professor"
      redirect_to timesheets_path(:status => "Signed")
    elsif user.type == "Finance"
      redirect_to timesheets_path(:status => "Approved")
    else
      redirect_to root_path
    end
  end

  def logout
    RubyCAS::Filter.logout(self)
  end

  private

  def check_for_user_in_db
    unless session[:cas_user].nil?
      if User.find_by_account(session[:cas_user]).nil? 
        flash[:error] = "User not found in Timeboard database."
      else
	@user = User.find_by_account(session[:cas_user])
      end
      
    end
  end
end

