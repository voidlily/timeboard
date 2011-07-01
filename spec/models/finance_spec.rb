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

require 'spec_helper'

describe Finance do
  pending "add some examples to (or delete) #{__FILE__}"
end

