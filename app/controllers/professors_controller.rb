class ProfessorsController < ApplicationController
  before_filter RubyCAS::Filter
  before_filter :check_for_user_in_db


def timesheet_list
end

private

def check_for_user_in_db
  if(User.find_by_account(session[:cas_user]).nil?)
    redirect_to root_path
  end
end

end
