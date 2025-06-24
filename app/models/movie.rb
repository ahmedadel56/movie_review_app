# app/models/movie.rb
class Movie < ApplicationRecord
  has_and_belongs_to_many :actors
  has_many :reviews, dependent: :destroy

  # Ransack configuration
  def self.ransackable_associations(auth_object = nil)
    [ "actors" ]
  end

  def self.ransackable_attributes(auth_object = nil)
    [ "title", "year", "director", "country" ]
  end

  # Cache management
  after_create :update_rating_cache
  after_destroy :update_rating_cache

  # Update rating cache when reviews change
  after_save_commit on: [ :create, :update ] do
    update_rating_cache
  end

  # Instance method for single movie update
  def update_rating_cache
    stats = reviews.average(:stars).to_h
    update_columns(
      average_rating: stats[:avg],
      reviews_count: stats[:count]
    )
  end

  # Class method for batch updates
  def self.batch_update_ratings
    connection.execute <<-SQL
      UPDATE movies
      SET average_rating = sub.avg_rating,
          reviews_count = sub.review_count
      FROM (
        SELECT movie_id,#{' '}
               COUNT(*) AS review_count,
               AVG(stars) AS avg_rating
        FROM reviews
        GROUP BY movie_id
      ) AS sub
      WHERE movies.id = sub.movie_id;
    SQL
  end

  # Query scopes
  def self.with_average_rating
    select("movies.*")
      .joins("LEFT JOIN LATERAL (
        SELECT COUNT(*) AS review_count,
               AVG(stars) AS avg_rating
        FROM reviews
        WHERE reviews.movie_id = movies.id
      ) AS stats ON TRUE")
      .select("stats.avg_rating AS average_rating, stats.review_count AS reviews_count")
  end

    # app/models/movie.rb
    def self.order_by_rating(sort_order = nil)
      case sort_order
      when "desc"
        order(Arel.sql("COALESCE(movies.average_rating, 0) DESC"))
      when "asc"
        order(Arel.sql("COALESCE(movies.average_rating, 0) ASC"))
      else
        order(Arel.sql("movies.id DESC"))
      end
    end
end
