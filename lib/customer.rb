require_relative 'movie'
require_relative 'rental'

class Customer
  attr_reader :name

  def initialize(name)
    @name = name
    @rentals = []
  end

  def add_rental(arg)
    @rentals << arg
  end

  def statement
    total_amount = 0
    @rentals.each do |rental|
      total_amount += rental.charge
    end

    frequent_renter_points = 0
    @rentals.each do |rental|
      frequent_renter_points += rental.frequent_renter_points
    end

    result = "Rental Record for #{@name}\n"
    @rentals.each do |rental|
      result += "  " + rental.movie.title + " " + rental.charge.to_s + "\n"
    end

    # add footer lines
    result += "Amount owed is #{total_amount}\n"
    result += "You earned #{frequent_renter_points} frequent renter points"
    result += "\n"
  end

  def charge(rental)
    this_amount = 0
    case rental.movie.price_code
    when Movie::REGULAR
      this_amount += 2
      this_amount += (rental.days_rented - 2) * 1.5 if rental.days_rented > 2
    when Movie::NEW_RELEASE
      this_amount += rental.days_rented * 3
    when Movie::CHILDRENS
      this_amount += 1.5
      this_amount += (rental.days_rented - 3) * 1.5 if rental.days_rented > 3
    end
    this_amount
  end
end
