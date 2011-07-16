class AdminController < ApplicationController
  before_filter RubyCAS::Filter
  before_filter :check_for_user_in_db
  before_filter :index

  def index
    @user = User.find_by_account(session[:cas_user])
    @user_list= User.find(:all)
    @title = "Admin"
  end

  def delete_user
    flash[:notice] = "User(s) Deleted"
  end

  def check_for_user_in_db
    if(User.find_by_account(session[:cas_user]).nil?)
      flash[:error] = "User not found in Timeboard database."
      redirect_to root_path
    end
  end

end
