require 'spec_helper'

describe Course do
  before(:each) do
    @attr = { :name => "TEST1300" }
  end

  it "should create a course given valid attributes" do
    Course.create!(@attr)
  end

  it "should require a name" do
    course = Course.new(@attr.merge(:name => ""))
    course.should_not be_valid
  end

  it "should belong to a professor" do
    professor = Factory(:professor)
    course = Factory(:course, :professor => professor)
    course.professor.id.should == professor.id
    course.professor.should == professor
  end

  it "should contain students" do
    course = Factory(:course)
    students = []
    2.times do
      student = Factory.next(:student)
      student.course = course
      student.save
      students << student
    end

    course.students.should == students
  end
end
