# == Schema Information
#
# Table name: timesheets
#
#  id         :integer         not null, primary key
#  student_id :integer
#  created_at :datetime
#  updated_at :datetime
#  start_date :date
#  end_date   :date
#

require 'spec_helper'

describe Timesheet do
  before(:each) do
    @student = Factory(:student)
    @attr = { :start_date => "2011-01-01",
              :end_date => "2011-01-14"}
  end

  it "should create a new instance given valid attributes" do
    @student.timesheets.create!(@attr)
  end
  
  describe "validation" do
    before(:each) do
      @timesheet = Timesheet.new({
        :student => @student,
        :start_date => "2011-01-01",
        :end_date => "2011-01-14"})
    end
    it "should require timesheets to last 2 weeks" do
      @timesheet.end_date = "2011-01-02"
      @timesheet.should_not be_valid
    end
    it "should make sure the start date is one day past a due date"
    it "should make sure the end date is a due date"
    it "should not allow timesheets to be created past the next due date"
  end

  describe "student associations" do
    before(:each) do
      @timesheet = @student.timesheets.create
      @timesheet.start_date = "2011-01-01"
      @timesheet.end_date = "2011-01-14"
      @timesheet.save
    end

    it "should have a student attribute" do
      @timesheet.should respond_to(:student)
    end

    it "should have the right associated student" do
      @timesheet.student_id.should == @student.id
      @timesheet.student.should == @student
    end
  end

  describe "workflow" do
    before(:each) do
      @timesheet = @student.timesheets.create
      @timesheet.start_date = "2011-01-01"
      @timesheet.end_date = "2011-01-14"
      @timesheet.save
    end

    it "should start as a draft" do
      @timesheet.should be_draft
      @timesheet.should_not be_signed
      @timesheet.should_not be_signed_exactly
      @timesheet.should_not be_approved
      @timesheet.should_not be_approved_exactly
      @timesheet.should_not be_processed
    end

    it "should be signable" do
      @timesheet.sign!
      @timesheet.should_not be_draft
      @timesheet.should be_signed
      @timesheet.should be_signed_exactly
      @timesheet.should_not be_approved
      @timesheet.should_not be_approved_exactly
      @timesheet.should_not be_processed
    end

    it "should be signed before being approved"
      #Should throw an error if we try to approve before signing
      #how do this?
    it "should be approveable" do
      @timesheet.sign!
      @timesheet.approve!
      @timesheet.should_not be_draft
      @timesheet.should be_signed
      @timesheet.should_not be_signed_exactly
      @timesheet.should be_approved
      @timesheet.should be_approved_exactly
      @timesheet.should_not be_processed
    end
    it "should be signed before processed"
      #Should throw an error if we try to approve before signing
      #how do this?
    it "should be approved before processed"
      #Should throw an error if we try to approve before signing
      #how do this?
    it "should be processable" do
      @timesheet.sign!
      @timesheet.approve!
      @timesheet.process!
      @timesheet.should_not be_draft
      @timesheet.should be_signed
      @timesheet.should_not be_signed_exactly
      @timesheet.should be_approved
      @timesheet.should_not be_approved_exactly
      @timesheet.should be_processed
    end
  end
end

