class Movie
  REGULAR = 0
  NEW_RELEASE = 1
  CHILDRENS = 2

  attr_reader :title
  attr_reader :price
  attr_reader :price_code

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
    end
  end

  def charge(days_rented)
    price.charge(days_rented)
  end

  def frequent_renter_points(days_rented)
    price.frequent_renter_points(days_rented)
    # Bonus point for a two day new release rental, otherwise just 1.
    if price_code == NEW_RELEASE && days_rented > 1
      2
    else
      1
    end
  end
end

module DefaultPrice
  def frequent_renter_points(days_rented)
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
