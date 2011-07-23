class AdminController < ApplicationController
  before_filter RubyCAS::Filter
  before_filter :check_for_user_in_db
  before_filter :index   #why is this here?
  before_filter :get_current_user
  before_filter :require_admin, :only => [:new, :create, :edit, :update, :index]

  def index
    @user = User.find_by_account(session[:cas_user])
    @user_list= User.find(:all)
    @course_list= Course.find(:all)
    @title = "Admin"
    @course = Course.new()
  end

  def delete_user
    @tempuser = User.find(params[:id])
    @tempuser.update_attributes(:active => "false")
    redirect_to '/admin/removeStudent'
    if(@tempuser.active==false)
      flash[:notice] = "User Inactive"
    end
    if(@tempuser.active==true)
      flash[:error] = "User is not a Student. It would be unwise to remove them."
    end
  end

  def delete_course
    @tempcourse = Course.find(params[:id])
    @tempcourse.destroy
    redirect_to '/admin/removeCourse'
    flash[:notice] = "Course Deleted"
  end

private

  def check_for_user_in_db
    if(User.find_by_account(session[:cas_user]).nil?)
      flash[:error] = "User not found in Timeboard database."
      redirect_to root_path
    end
  end


  def get_current_user
    @current_user = User.find_by_account(session[:cas_user])
  end

  def require_admin
    unless @current_user.admin?
      flash[:error] = "You must be an administrator to access this section"
      redirect_to root_path # halts request cycle
    end
  end


end
