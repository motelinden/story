class CreateStatistics < ActiveRecord::Migration
  def change
    create_table :statistics do |t|
      
      t.integer :story_id,        null: false
      t.integer :node_id
      t.integer :reading,         null: false, default: 0
      t.integer :rating,          null: false, default: 0

      t.timestamps
    end
    add_index :statistics, :story_id
    add_index :statistics, :node_id
  end
end
