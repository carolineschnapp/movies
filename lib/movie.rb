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
    result = 0
    case price_code
    when REGULAR
      result = price.charge(days_rented)
    when NEW_RELEASE
      result = price.charge(days_rented)
    when CHILDRENS
      price.charge(days_rented)
      result += 1.5
      result += (days_rented - 3) * 1.5 if days_rented > 3
    end
    result
  end

  def frequent_renter_points(days_rented)
    # Bonus point for a two day new release rental, otherwise just 1.
    price_code == NEW_RELEASE && days_rented > 1 ? 2 : 1
  end
end

class RegularPrice
  def charge(days_rented)
    days_rented > 2 ? days_rented * 1.5 - 1 : 2
  end
end

class NewReleasePrice
  def charge(days_rented)
    days_rented * 3
  end
end

class ChildrensPrice
  def charge(days_rented)
    result = 0
    result += 1.5
    result += (days_rented - 3) * 1.5 if days_rented > 3
    result
  end
end
