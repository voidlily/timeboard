require 'spec_helper'

describe Student do
  before(:each) do
    @attr = {
      :name => "Test Student",
      :account => "teststudent3",
      :email => "teststudent@example.com",
      :employee_id => "333333"
    }
  end

  describe "timesheet attribute" do
    before(:each) do
      @student = Student.create(@attr)
      @timesheet = Factory(:timesheet, :student => @student)
    end
    it "should have a timesheets attribute" do
      @student.should respond_to(:timesheets)
    end
    it "should contain a timesheet" do
      @student.timesheets.should == [@timesheet]
    end
  end
end
