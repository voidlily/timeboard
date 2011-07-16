class UsersController < ApplicationController 
  before_filter RubyCAS::Filter 
  before_filter :check_for_user_in_db 

  def index
    @user = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.new(params[:user])
    @user = @user.userize
    respond_to do |format|
      if @user.save
	format.html {render 'editStudent', :notice=>"User edited."}
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
