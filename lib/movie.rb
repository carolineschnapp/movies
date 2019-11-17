require 'forwardable'

class Movie
  extend Forwardable

  REGULAR = 0
  NEW_RELEASE = 1
  CHILDRENS = 2

  attr_reader :title, :price, :price_code

  def_delegators :price, :rental_price_for, :frequent_renter_points_for

  def initialize(title, price_code)
    @title = title
    self.price_code = price_code
  end

  def price_code=(price_code)
    @price_code = price_code
    @price = case price_code
      when REGULAR then RegularPrice.new
      when NEW_RELEASE then NewReleasePrice.new
      when CHILDRENS then ChildrensPrice.new
      when PORN then PornPrice.new
    end
  end
end

class RegularPrice
  def rental_price_for(days_rented)
    return 2 if days_rented <= 2
    1.5 * days_rented - 1
  end

  def frequent_renter_points_for(_)
    1
  end
end

class NewReleasePrice
  def rental_price_for(days_rented)
    days_rented * 3
  end

  def frequent_renter_points_for(days_rented)
    return 2 if days_rented > 1
    1
  end
end

class ChildrensPrice
  def rental_price_for(days_rented)
    return 1.5 if days_rented <= 3
    days_rented * 1.5 - 3
  end

  def frequent_renter_points_for(_)
    1
  end
end
