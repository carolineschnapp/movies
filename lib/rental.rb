require_relative 'movie'

class Rental
  attr_reader :movie, :days_rented

  def initialize(movie, days_rented)
    @movie, @days_rented = movie, days_rented
  end

  def price
    movie.rental_price_for(days_rented)
  end

  def frequent_renter_points
    movie.frequent_renter_points_for(days_rented)
  end

  def to_s
    "  #{movie.title} #{price}"
  end
end
