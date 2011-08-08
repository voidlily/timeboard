class UsersController < ApplicationController 
  before_filter RubyCAS::Filter 
  before_filter :check_for_user_in_db 
  before_filter :get_current_user
  before_filter :require_admin, :only => [:new, :create]
  before_filter :require_admin_or_finance, :only => [ :edit, :update]


  def new
    @user = User.new
    @title = "User creation"
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = "User successfully created."
      if @user.type == "Student"
        student = Student.find(@user.id)
        AddAndOutdateTimesheets.add_missing_timesheets(student)
      end
      redirect_to @user
    else
      flash[:error] = "One or more fields was not filled in or was not of the correct input format."
      @title = "Sign up"
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
    unless @user.id == @current_user.id || @current_user.admin?
      flash[:error] = "You must be an administrator to access this section"
      redirect_to root_path
    end
  end

  def edit
    @user = User.find(params[:id])
    @title = "Edit user"
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated."
      redirect_to @user
    else
      flash[:error] = "Some input was either blank or of incorrect format."
      @title = "Edit user"
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
      flash[:error] = "You must be an administrator to access this section"
      redirect_to root_path # halts request cycle
    end
  end
  
  def require_admin_or_finance
    if @current_user.nil?
      get_current_user
    end
    unless @current_user.admin? || @current_user.type == "Finance"
      flash[:error] = "You must be an administrator to access this section"
      redirect_to root_path # halts request cycle
    end
  end

end
