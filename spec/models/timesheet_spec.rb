require 'spec_helper'

describe Timesheet do
  before(:each) do
    @student = Factory(:student)
  end

  it "should create a new instance given valid attributes" do
    @student.timesheets.create!(@attr)
  end
  
  describe "validation" do
    it "should require timesheets to last 2 weeks"
    it "should make sure the start date is one day past a due date"
    it "should make sure the end date is a due date"
    it "should not allow timesheets to be created past the next due date"
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

  describe "workflow" do
    before(:each) do
      @timesheet = @student.timesheets.create
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
