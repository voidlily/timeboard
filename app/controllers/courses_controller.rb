class CoursesController < ApplicationController 
  before_filter RubyCAS::Filter
  before_filter :check_for_user_in_db
  before_filter :get_current_user
  before_filter :require_admin, :only => [:new, :create, :edit, :update]

  def index
    @user = User.find_by_account(session[:cas_user])
    if(@user.type == "Professor")
      @course_list = @user.courses
    elsif(@user.type == "Student")
      if(@user.course.nil?)
        redirect_to root_path
      else  
        redirect_to @user.course
      end
    end
  end

  def new
    @course = Course.new
    @title = "Course creation"
  end

  def show
    @user = User.find_by_account(session[:cas_user])
    unless @user.id == @current_user.id || @current_user.admin?
      flash[:error] = "You must be an administrator in to access this section"
      redirect_to root_path
    end
    @course = Course.find(params[:id])    

  end

  def create
    @course = Course.new(params[:course])
    if @course.save
      flash[:success] = "Course successfully created."
      redirect_to @course
    else
      flash[:error] = "One or more fields was not filled in or was not of the correct input format."
      @title = "Course creation"
      render 'new'
    end
  end

  def edit
    @course = Course.find(params[:id])
    @title = "Edit course"
  end

  def update
    @course = Course.find(params[:id])
    if @course.update_attributes(params[:course])
      flash[:success] = "Course updated."
      redirect_to @course
    else
      flash[:error] = "Some input was either blank or of incorrect format."
      @title = "Edit course"
      render 'edit'
    end
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
      flash[:error] = "You must be an administrator in to access this section"
      redirect_to root_path # halts request cycle
    end
  end

end
