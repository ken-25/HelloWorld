class AddAdminToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :admin, :boolean
    remove_column :users, :authority, :string
  end
end
