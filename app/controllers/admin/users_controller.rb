class Admin::UsersController < ApplicationController
  before_filter RubyCAS::Filter
  before_filter :require_admin

  def require_admin
    unless @current_user.admin?
      flash[:error] = "You must be an administrator to access this section"
      redirect_to root_path # halts request cycle
    end
  end

  def csv_import
    # CSV schema:
    # name,email,account,course_name
    
    # First, set all students to inactive
    # This should be done with update_all for less queries
    Student.all.each do |student|
      student.active = false
      student.save
    end

    # @file = ???
    csv = FCSV.new(@file)
    csv.each do |row|
      student = Student.find_by_account(row[2]) || Student.new
      course |= Course.find_by_name(row[3])
      student.update_attributes(:name => row[0], :email => row[1], :account => row[2], :course => course, :active => true)
      student.save
    end

    flash[:notice] = "Successfully imported student CSV."

    # redirect_to ???

  rescue => exception
    flash[:error] = "Error importing student CSV. (#{ERB::Util.h(exception.to_s)})"
    # redirect_to ???
  end
end
