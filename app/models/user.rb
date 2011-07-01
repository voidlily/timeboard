# == Schema Information
#
# Table name: users
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  account     :string(255)
#  email       :string(255)
#  employee_id :string(255)
#  admin       :boolean
#  type        :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  course_id   :integer
#

class User < ActiveRecord::Base

  attr_accessible :name, :account, :email

  validates :name, :presence => true
  validates :account, :presence => true,
                      :uniqueness => { :case_sensitive => false }
  validates :email, :presence => true,
                    :email => true,
                    :uniqueness => { :case_sensitive => false }
end

