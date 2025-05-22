class MoviesController < ApplicationController
  def index
    @movies = 
      if params[:q].present?
        # Movie.sql_search(params[:q])
        results = Movie.search(params[:q])
        # results = results.near(params[:location]) if params[:location].present?
        # results = results.where(genre: params[:genre]) if params[:genre].present?
        # results = results.where(start_date: params[:start_date]..params[:end_date]) if params[:start_date].present?
        # results = results.where("price > ?", params[:min_price]) if params[:min_price].present?

        results
      else
        Movie.all
      end
  end
end
