class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.text    	:story_content, null: false
      t.references 	:user

      t.timestamps
    end
  end
end
