class AddIndicesToTimesheetEntries < ActiveRecord::Migration
  def change
    add_index :timesheet_entries, :timesheet_id
    add_index :timesheet_entries, [:timesheet_id, :date], :unique => true
  end
end
