class UserImg < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :img_name, :string
  end
end
