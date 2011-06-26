class CreateTimesheetStatuses < ActiveRecord::Migration
  def change
    create_table :timesheet_statuses do |t|
      t.integer :timesheet_id
      t.string :status
      t.string :reason

      t.timestamps
    end

    add_index :timesheet_statuses, [:timesheet_id, :status]
  end
end
