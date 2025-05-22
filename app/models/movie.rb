class Movie < ApplicationRecord
  belongs_to :director

  # PG SEARCH IMPLEMENTATION

  include PgSearch::Model
  multisearchable against: [:title, :synopsis]
  # pg_search_scope :search_by_title_and_synopsis,
  #   against: [:title, :synopsis],
  #   using: {
  #     tsearch: { prefix: true }
  #   }

  pg_search_scope :search, # => can be used with Movie.search
    against: [:title, :synopsis],
    associated_against: {
      director: [ :first_name, :last_name ]
    },
    using: {
      tsearch: { prefix: true }
    }

  # # MANUAL SQL / ACTIVE RECORD IMPLEMENTATION
  # def self.sql_search(query)
  #   sql_query = <<~SQL
  #       movies.title @@ :q OR
  #       movies.synopsis @@ :q OR
  #       directors.first_name @@ :q OR
  #       directors.last_name @@ :q
  #       SQL

  #   Movie.joins(:director).where(sql_query, q: "%#{query}%")
  # end
end
