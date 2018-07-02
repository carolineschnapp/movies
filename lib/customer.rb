require_relative 'movie'
require_relative 'rental'

class Customer
  attr_reader :name, :rentals

  def initialize(name)
    @name = name
    @rentals = []
  end

  def add_rental(arg)
    @rentals << arg
  end

  def statement
    TextStatement.for(self).value
  end

  def html_statement
    HtmlStatement.for(self).value
  end

  def line_items
    rentals.map { |rental| "  #{rental}" }.join("\n")
  end

  def html_line_items
    rentals.map { |rental| "<li>#{rental}</li>" }.join("\n  ")
  end

  def total_amount
    rentals.inject(0) { |total, rental| total + rental.charge }
  end

  def frequent_renter_points
    rentals.inject(0) { |total, rental| total + rental.frequent_renter_points }
  end
end

class Statement
  attr_reader :customer

  def initialize(customer)
    @customer = customer
  end

  def self.for(customer)
    new(customer)
  end

  def header_string
    "Rental Record for #{customer.name}"
  end

  def amount_owned_line
    "Amount owed is #{customer.total_amount}"
  end

  def frequent_rental_points_line
    "You earned #{customer.frequent_renter_points} frequent renter points"
  end
end

class TextStatement < Statement
  def value
    <<~STATEMENT
      #{header_string}
      #{each_line_item.each(customer.rentals).join("\n")}
      #{amount_owned_line}
      #{frequent_rental_points_line}
    STATEMENT
  end

  def each_line_item(x)
    Proc.new { |x| "  #{x}" }
  end
end

class HtmlStatement < Statement
  def value
    <<~STATEMENT
      <h1>#{header_string}</h1>
      <ul>
        #{customer.html_line_items}
      </ul>
      <p>#{amount_owned_line}</p>
      <p>#{frequent_rental_points_line}</p>
    STATEMENT
  end

  def each_line_item(x)
    Proc.new { |x| "<li>#{x}</li>" }
  end
end
