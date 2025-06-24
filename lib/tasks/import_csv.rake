# lib/tasks/import_csv.rake
# lib/tasks/import_csv.rake
require "smarter_csv"
require "activerecord-import"

namespace :import do
  desc "Import movies and reviews from CSV"
  task data: :environment do
    import_movies
    import_reviews
    update_rating_cache
  end

  def import_movies
    file = Rails.root.join("db", "movies.csv")

    SmarterCSV.process(file).each do |row|
      movie = Movie.find_or_create_by!(
        title: row[:movie],
        defaults: {
          description: row[:description],
          year: row[:year].to_i,
          director: row[:director],
          country: row[:country]
        }
      )

      actor = Actor.find_or_create_by!(name: row[:actor])
      location = Location.find_or_create_by!(name: row[:filming_location])

      movie.actors << actor unless movie.actors.include?(actor)
      movie.locations << location unless movie.locations.include?(location)
    end
  end

  def import_reviews
    file = Rails.root.join("db", "reviews.csv")

    reviews = SmarterCSV.process(file).map do |row|
      movie = Movie.find_by(title: row[:movie])
      next unless movie

      Review.new(
        user: row[:user],
        stars: row[:stars].to_i,
        review_text: row[:review],
        movie_id: movie.id
      )
    end.compact

    Review.import reviews, recursive: true
  end

  def update_rating_cache
    Movie.find_each(&:calculate_rating_cache)
  end
end
