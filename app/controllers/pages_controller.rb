class PagesController < ApplicationController
  before_filter RubyCAS::Filter, :only => :login

  def home
  end

  def login
    redirect_to root_path
  end

  def logout
    RubyCAS::Filter.logout(self)
  end
end

