class CreateUserActions < ActiveRecord::Migration
  def change
    create_table :user_actions do |t|

      t.integer :story_id,          null: false
      t.integer :node_id
      t.integer :user_id
      t.integer :action_type,       null: false

      t.timestamps
    end
    add_index :user_actions, :story_id
    add_index :user_actions, :node_id
    add_index :user_actions, :user_id
  end
end
