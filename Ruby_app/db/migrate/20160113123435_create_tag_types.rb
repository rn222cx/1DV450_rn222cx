class CreateTagTypes < ActiveRecord::Migration
  def change
    create_table :tag_types do |t|

      t.string :era
    end
  end
end
