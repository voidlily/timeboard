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

  attr_accessible :name, :account, :email, :employee_id, :admin, :type, :course_id, :active

  scope :active, where("active = ?", true)

  validates :name, :presence => true
  validates :account, :presence => true,
                      :uniqueness => { :case_sensitive => false }
  validates :email, :presence => true,
                    :email => true,
                    :uniqueness => { :case_sensitive => false }
#return an array [User, User, ...], instead of [Admin, Director, Director, Instructor, ...]
    def self.all_without_typecast
      self.all.collect! do |u|
          u.becomes(User)
      end
    end

    #makes subclasses of User (Admin, Director, ...) into User class
    def userize #cast_into_user could be a better name
      self.becomes(User)
    end

end

