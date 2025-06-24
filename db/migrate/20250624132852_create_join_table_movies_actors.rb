class CreateJoinTableMoviesActors < ActiveRecord::Migration[8.0]
  def change
    create_join_table :movies, :actors do |t|
      t.index [ :movie_id, :actor_id ]
    end
  end
end
