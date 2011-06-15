require 'spec_helper'

describe Professor do
  before(:each) do
    @attr = {
      :name => "Test Professor",
      :account => "testprofessor3",
      :email => "testprofessor@example.com"
    }
    @professor = Professor.create(@attr)
  end

  describe "courses attribute" do
    before(:each) do
      @course1 = Factory.next(:course)
      @course2 = Factory.next(:course)
      [@course1, @course2].each do |c|
        c.professor = @professor
        c.save
      end
    end
    it "should respond to courses" do
      @professor.should respond_to(:courses)
    end
    it "should contain all courses" do
      @professor.courses.should == [@course1, @course2]
    end
  end
  describe "timesheets attribute" do
    before(:each) do
      @course1 = Factory.next(:course)
      @course1.professor = @professor
      @course1.save
      @student1 = Factory.next(:student)
      @student2 = Factory.next(:student)
      [@student1, @student2].each do |s|
        s.course = @course1
        s.save
      end
      @timesheet1 = @student1.timesheets.create
      @timesheet2 = @student2.timesheets.create
    end
    it "should respond to timesheets" do
      @professor.should respond_to(:timesheets)
    end
    it "should contain all courses' students timesheets" do
      @professor.timesheets.should == [@timesheet1, @timesheet2]
    end
  end
end
