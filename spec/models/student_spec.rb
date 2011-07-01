require 'spec_helper'

describe Student do
  before(:each) do
    @attr = {
      :name => "Test Student",
      :account => "teststudent3",
      :email => "teststudent@example.com",
      :employee_id => "333333"
    }
    @student = Student.create(@attr)
  end

  describe "timesheet attribute" do
    before(:each) do
      @timesheet1 = Factory(:timesheet, :student => @student)
      @timesheet2 = Factory(:timesheet, :student => @student)
    end
    it "should have a timesheets attribute" do
      @student.should respond_to(:timesheets)
    end
    it "should contain timesheets" do
      @student.timesheets.should == [@timesheet1, @timesheet2]
    end
  end

  describe "course attribute" do
    before(:each) do
      @course = Factory(:course)
      @student.course = @course
    end
    it "should have a courses attribute" do
      @student.should respond_to(:course)
    end
    it "should contain courses" do
      @student.course.should == @course
    end
  end
end

# == Schema Information
#
# Table name: users
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  account     :string(255)
#  email       :string(255)
#  employee_id :string(255)
#  admin       :boolean
#  type        :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  course_id   :integer
#

