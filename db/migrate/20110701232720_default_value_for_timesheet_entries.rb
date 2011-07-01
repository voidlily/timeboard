class DefaultValueForTimesheetEntries < ActiveRecord::Migration
  def up
    change_column :timesheet_entries, :hours, :decimal, :null => false, :default => 0
  end

  def down
    change_column :timesheet_entries, :hours, :decimal, :null => true, :default => nil
  end
end
