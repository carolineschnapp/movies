require 'forwardable'

class Movie
  extend Forwardable

  REGULAR = 0
  NEW_RELEASE = 1
  CHILDRENS = 2
  PORN = 3

  attr_reader :title, :price, :price_code

  def_delegators :price, :charge, :frequent_renter_points

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

module DefaultPrice
  def frequent_renter_points(_)
    1
  end
end

class RegularPrice
  include DefaultPrice

  def charge(days_rented)
    days_rented > 2 ? days_rented * 1.5 - 1 : 2
  end
end

class NewReleasePrice
  def charge(days_rented)
    days_rented * 3
  end

  def frequent_renter_points(days_rented)
    days_rented > 1 ? 2 : 1
  end
end

class ChildrensPrice
  include DefaultPrice

  def charge(days_rented)
    days_rented > 3 ? days_rented * 1.5 - 3 : 1.5
  end
end

class PornPrice
  def charge(days_rented)
    days_rented / 3
  end

  def frequent_renter_points(_)
    0
  end
end
