class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :user_id,             null: false
      t.integer :story_id,            null: false
      t.integer :node_id,             null: false
      t.integer :parent_id
      t.text :content,                null: false, default: ""

      t.timestamps
    end
    add_index :comments, :user_id
    add_index :comments, :story_id
    add_index :comments, :node_id
  end
end
