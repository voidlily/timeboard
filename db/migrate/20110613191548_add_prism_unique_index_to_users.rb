class AddPrismUniqueIndexToUsers < ActiveRecord::Migration
  def change
    add_index :users, :prism, :unique => true
  end
end
