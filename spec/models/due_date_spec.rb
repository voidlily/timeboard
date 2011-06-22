require 'spec_helper'

describe DueDate do
  before(:each) do
    DueDate.create!(:date => Date.today)
  end
  it "should be today" do
    DueDate.date.should == Date.today
  end
  it "should update to 2 weeks from now" do
    DueDate.increment!
    DueDate.date.should == Date.today + 2.weeks
  end
end
