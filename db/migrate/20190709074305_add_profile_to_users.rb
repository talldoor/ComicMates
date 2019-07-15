class AddProfileToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :my_book1, :string
    add_column :users, :my_book2, :string
    add_column :users, :my_book3, :string
    add_column :users, :self_introduction, :text
  end
end
