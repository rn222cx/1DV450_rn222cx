class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.references :user
      
      t.string "title", :limit => 50
      t.text "description"
      t.float "longitude"
      t.float "latitude"
      t.timestamps null: false
    end
  end
end
