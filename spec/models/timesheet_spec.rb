require 'spec_helper'

describe Timesheet do
  before(:each) do
    @student = Factory(:student)
  end

  it "should create a new instance given valid attributes" do
    @student.timesheets.create!(@attr)
  end

  describe "student associations" do
    before(:each) do
      @timesheet = @student.timesheets.create
    end

    it "should have a student attribute" do
      @timesheet.should respond_to(:student)
    end

    it "should have the right associated student" do
      @timesheet.student_id.should == @student.id
      @timesheet.student.should == @student
    end
  end
end
