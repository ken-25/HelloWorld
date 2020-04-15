class AddcolumnUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :authority, :string
    add_column :users, :body_length, :integer
    add_column :users, :giraffe_type, :string
    add_column :users, :place, :string
  end
end
