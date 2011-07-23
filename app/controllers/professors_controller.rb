class ProfessorsController < UsersController
  before_filter RubyCAS::Filter
  before_filter :check_for_user_in_db
  before_filter :get_current_user

def timesheet_list
end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user = @user.userize
    respond_to do |format|
      if @user.update_attributes(params[:user])
	format.html {render 'editStudent', :notice=>"Professor edited."}
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

  def get_current_user
    @current_user = User.find_by_account(session[:cas_user])
  end

end
