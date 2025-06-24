class CreateJoinTableMoviesLocations < ActiveRecord::Migration[8.0]
  def change
    create_join_table :movies, :locations do |t|
      t.index [ :movie_id, :location_id ]
    end
  end
end
