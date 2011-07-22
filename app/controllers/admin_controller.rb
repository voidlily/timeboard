class AdminController < ApplicationController
  before_filter RubyCAS::Filter
  before_filter :check_for_user_in_db
  before_filter :index

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

  def check_for_user_in_db
    if(User.find_by_account(session[:cas_user]).nil?)
      flash[:error] = "User not found in Timeboard database."
      redirect_to root_path
    end
  end


end
