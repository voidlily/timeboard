class CoursesController < ApplicationController 
  before_filter RubyCAS::Filter
  before_filter :check_for_user_in_db

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


  def show
    @user = User.find_by_account(session[:cas_user])
    @course = Course.find(params[:id])    

  end

  def create
    @course = Course.new(params[:course])
    respond_to do |format|
      if @course.save
	format.html {redirect_to 'admin/index', :notice=>"Course created."}
      end
    end
  end

  def edit
    @course = Course.find(params[:id])
  end

  def update
    @course = Course.find(params[:id])
 
    respond_to do |format|
      if @course.update_attributes(params[:course])
        format.html {render 'editCourse', :notice=>"Course edited."}
      end
    end
  end

private

  def check_for_user_in_db
    if(User.find_by_account(session[:cas_user]).nil?)
      flash[:error] = "User not found in Timeboard database."
      redirect_to root_path
    end
  end

end
