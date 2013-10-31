class CreateTags < ActiveRecord::Migration
  def change
       create_table :tags do |t|
          t.string :tag_category
          t.timestamps
       end
  end
end
