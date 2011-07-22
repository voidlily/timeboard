class StudentsController < UsersController

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user = @user.userize
    respond_to do |format|
    if @user.update_attributes(params[:user])
	format.html {render root_path, :notice=>"Student edited."}
      end
    end
  end

end
