class StudentsController < UsersController
  before_filter RubyCAS::Filter
  before_filter :check_for_user_in_db
  before_filter :get_current_user

  def edit
    @user = User.find(params[:id])
    @title = "Edit Student"
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


  def  get_current_user
    @current_user = User.find_by_account(session[:cas_user])
  end


end
