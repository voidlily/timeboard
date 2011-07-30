class HolidaysController < ApplicationController
  before_filter RubyCAS::Filter
  before_filter :check_for_user_in_db
  before_filter :get_current_user
  before_filter :require_admin

  def index
    @holidays = Holiday.all
  end

  def create
    Holiday.all.each { |h| h.destroy }
    holidayStrings = params[:holidayString].delete("\r").split
    logger.debug "holiday strings: #{holidayStrings}"
    holidayStrings.each do |str|
      Holiday.create(:date => Date.strptime( str, "%m/%d/%Y" ))
    end
    redirect_to holidays_path
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
