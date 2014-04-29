class CreateNodes < ActiveRecord::Migration
  def change
    create_table :nodes do |t|
      
      t.integer :story_id,        null: false
      t.integer :parent_id
      t.integer :user_id,         null: false
      t.integer :level,           null: false, default: 2
      t.text :path
      t.text :content,            null: false, default: ""

      t.timestamps
    end
    add_index :nodes, :story_id
    add_index :nodes, :user_id
  end
end
