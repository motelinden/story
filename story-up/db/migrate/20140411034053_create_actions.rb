class CreateActions < ActiveRecord::Migration
  def change
    create_table :actions do |t|
      t.integer :story_id
      t.integer :node_id
      t.integer :user_id
      t.integer :action_type

      t.timestamps
    end
    add_index :actions, :story_id
    add_index :actions, :node_id
    add_index :actions, :user_id
  end
end
