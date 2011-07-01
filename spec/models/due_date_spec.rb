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

# == Schema Information
#
# Table name: due_dates
#
#  id         :integer         not null, primary key
#  date       :date
#  created_at :datetime
#  updated_at :datetime
#

