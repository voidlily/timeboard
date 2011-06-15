class RenameUserPrismColumn < ActiveRecord::Migration
  def up
    rename_column :users, :prism, :account
  end

  def down
    rename_column :users, :account, :prism
  end
end
