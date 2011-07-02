# == Schema Information
#
# Table name: timesheet_entries
#
#  id           :integer         not null, primary key
#  timesheet_id :integer
#  date         :date
#  hours        :decimal(, )     default(0.0), not null
#  created_at   :datetime
#  updated_at   :datetime
#

require 'spec_helper'

describe TimesheetEntry do
  #Timesheet entries are automatically created every 2 weeks
  #with a new timesheet at maintenance
  describe "validation" do
    before(:each) do
      @timesheet = Factory(:timesheet)
      @attr = { :timesheet => @timesheet,
                :date => Date.today,
                :hours => 0 }
    end
    it "should create a valid instance given valid attributes" do
      TimesheetEntry.create!(@attr)
    end
    it "should require a date" do
      entry = TimesheetEntry.create(@attr.merge({:date => nil}))
      entry.should_not be_valid
    end
    it "should require hours" do
      entry = TimesheetEntry.create(@attr.merge({:hours => nil}))
      entry.should_not be_valid
    end
    it "should reject negative hours" do
      entry = TimesheetEntry.create(@attr.merge({:hours => -1}))
      entry.should_not be_valid
    end
  end
end

