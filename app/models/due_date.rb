# == Schema Information
#
# Table name: due_dates
#
#  id         :integer         not null, primary key
#  date       :date
#  created_at :datetime
#  updated_at :datetime
#

class DueDate < ActiveRecord::Base
  def self.date
    DueDate.last.date
  end
  def self.date=(date)
    DueDate.last.date = date
  end
  def self.today?
    DueDate.last.today?
  end
  def self.increment!
    last = DueDate.last
    last.date += 2.weeks
    last.save
  end
end

