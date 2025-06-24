# app/controllers/movies_controller.rb
class MoviesController < ApplicationController
  # app/controllers/movies_controller.rb
  def index
    sort_order = %w[desc asc].include?(params[:sort]) ? params[:sort] : nil

    @q = Movie.ransack(params.fetch(:q, {}).permit(:actors_name_cont))
    @movies = @q.result.with_average_rating.order_by_rating(sort_order)
                      .includes(:actors, :reviews).page(params[:page]).per(10)
  end
end
