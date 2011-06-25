require 'spec_helper'

describe TimesheetStatus do
  before(:each) do
    @student = Factory(:student)
    @timesheet = Factory(:timesheet, :student => @student)
    @timesheet_status = TimesheetStatus.create(
      :timesheet => @timesheet,
      :status => "Draft")
  end
  it "should create a status given valid attributes" do
    TimesheetStatus.create!(:timesheet => @timesheet, :status => "Draft")
  end
  it "should require a timesheet" do
    @timesheet_status.timesheet = nil
    @timesheet_status.should_not be_valid
  end
  it "should be valid for valid status names" do
    @timesheet_status.status = "Signed"
    @timesheet_status.should be_valid
  end
  it "should not be valid for invalid status names" do
    @timesheet_status.status = "asdfasdfasdf"
    @timesheet_status.should_not be_valid
  end
end
