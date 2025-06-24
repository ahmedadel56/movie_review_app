class AddRatingCacheToMovies < ActiveRecord::Migration[8.0]
  def change
    add_column :movies, :average_rating, :float
    add_column :movies, :reviews_count, :integer
  end
end
