class PagesController < ApplicationController
  before_filter RubyCAS::Filter, :only => :login
  before_filter :check_for_user_in_db

  def home
  end

  def login
    redirect_to root_path
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

