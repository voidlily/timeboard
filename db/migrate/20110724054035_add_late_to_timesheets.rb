class AddLateToTimesheets < ActiveRecord::Migration
  def change
    add_column :timesheets, :late, :boolean, :null => false, :default => false
  end
end
