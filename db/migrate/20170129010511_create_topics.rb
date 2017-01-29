class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.text :content
      t.string :image

      t.timestamps null: false
    end
  end
end
