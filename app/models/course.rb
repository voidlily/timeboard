class Course < ActiveRecord::Base
  attr_accessible :name

  belongs_to :professor
  has_many :students
  validates :name, :presence => true
end

# == Schema Information
#
# Table name: courses
#
#  id           :integer         not null, primary key
#  name         :string(255)
#  professor_id :integer
#  created_at   :datetime
#  updated_at   :datetime
#

