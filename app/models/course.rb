class Course < ActiveRecord::Base
  attr_accessible :name

  belongs_to :professor
  has_many :students
  validates :name, :presence => true
end
