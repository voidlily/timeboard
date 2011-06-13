class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :prism
      t.string :email
      t.string :employee_id
      t.boolean :admin
      t.string :type

      t.timestamps
    end
  end
end
