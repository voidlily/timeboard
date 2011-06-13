class CreateTimesheetEntries < ActiveRecord::Migration
  def change
    create_table :timesheet_entries do |t|
      t.integer :timesheet_id
      t.date :date
      t.decimal :hours, :scale => 1

      t.timestamps
    end
  end
end
