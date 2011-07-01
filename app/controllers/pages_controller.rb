class PagesController < ApplicationController
  before_filter RubyCAS::Filter, :only => :login
 # before_filter RubyCAS::Filter.logout(self), :only => :logout 

  def home
  end

  def login
    redirect_to root_path
  end

  def logout
   # RubyCAS::Filter.logout(self, :destination => "http://localhost:3000/")
  end
end

