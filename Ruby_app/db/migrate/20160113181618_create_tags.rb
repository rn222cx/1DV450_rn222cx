class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.references :tag_type
      t.references :story

      t.timestamps null: false
    end
  end
end
