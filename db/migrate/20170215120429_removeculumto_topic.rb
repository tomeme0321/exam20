class RemoveculumtoTopic < ActiveRecord::Migration
  def change
    remove_column :topics, :image, :string
    add_column :topics, :image, :string
  end
end
