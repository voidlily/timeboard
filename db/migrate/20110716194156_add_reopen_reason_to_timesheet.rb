class AddReopenReasonToTimesheet < ActiveRecord::Migration
  def change
    add_column :timesheets, :reopen_reason, :string
  end
end
