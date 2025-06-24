class AddIndexes < ActiveRecord::Migration[8.0]
  def change
    add_index :movies, :title
    add_index :actors, :name
    add_index :reviews, :stars
    add_index :movies, :average_rating
    add_index :movies, :reviews_count
  end
end
