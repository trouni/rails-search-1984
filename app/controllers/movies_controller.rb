class MoviesController < ApplicationController
  def index
    @movies = 
      if params[:q].present?
        query = <<~SQL
        movies.title @@ :q OR
        movies.synopsis @@ :q OR
        directors.first_name @@ :q OR
        directors.last_name @@ :q
        SQL

        Movie.joins(:director).where(query, q: "%#{params[:q]}%")
      else
        Movie.all
      end
  end
end
