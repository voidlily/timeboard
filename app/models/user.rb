class User < ActiveRecord::Base

  attr_accessible :name, :account, :email

  validates :name, :presence => true
  validates :account, :presence => true,
                      :uniqueness => { :case_sensitive => false }
  validates :email, :presence => true,
                    :email => true,
                    :uniqueness => { :case_sensitive => false }
end
