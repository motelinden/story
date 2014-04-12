class RemoveUniqueValidationOfUsernameFromUser < ActiveRecord::Migration
  def change
  	remove_index :users, :username
  	add_index    :users, :username
  	add_index    :users, :email
  end
end
