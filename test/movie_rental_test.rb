require 'minitest/autorun'
require_relative '../lib/customer'
require_relative '../lib/movie'
require_relative '../lib/rental'
require 'pry'

class MovieRentalTest < Minitest::Test
  def setup
    @customer = Customer.new('Caroline')
    @children_movie = Movie.new('Ratatouille', Movie::CHILDRENS)
    @regular_movie = Movie.new('The Big Lebowski', Movie::REGULAR)
    @new_release_movie = Movie.new('Frantz', Movie::NEW_RELEASE)
  end

  def test_movie_has_title
    assert_equal 'Ratatouille', @children_movie.title
  end

  def test_movie_has_price_code
    assert_equal Movie::CHILDRENS, @children_movie.price_code
  end

  def test_movie_has_price_code_that_can_be_changed
    @children_movie.price_code = Movie::NEW_RELEASE
    assert_equal Movie::NEW_RELEASE, @children_movie.price_code
  end

  def test_customer_has_name
    assert_equal 'Caroline', @customer.name
  end

  def test_customer_can_be_given_a_statement_for_one_rental
    @customer.add_rental(Rental.new(@new_release_movie, 3))
    expected_statement = <<~STATEMENT
      Rental Record for Caroline
        Frantz 9
      Amount owed is 9
      You earned 2 frequent renter points
    STATEMENT
    assert_equal expected_statement, @customer.statement
  end

  def test_customer_can_be_given_a_statement_for_several_rentals
    @customer.add_rental(Rental.new(@children_movie, 2))
    @customer.add_rental(Rental.new(@regular_movie, 3))
    @customer.add_rental(Rental.new(@new_release_movie, 1))
    expected_statement = <<~STATEMENT
      Rental Record for Caroline
        Ratatouille 1.5
        The Big Lebowski 3.5
        Frantz 3
      Amount owed is 8.0
      You earned 3 frequent renter points
    STATEMENT
    assert_equal expected_statement, @customer.statement
  end

  def test_customer_can_be_given_a_statement_in_html
    skip
    @customer.add_rental(Rental.new(@children_movie, 2))
    @customer.add_rental(Rental.new(@regular_movie, 3))
    @customer.add_rental(Rental.new(@new_release_movie, 1))
    expected_html_statement = <<~STATEMENT
      <h1>Rental Record for Caroline</h1>
      <ul>
        <li>Ratatouille 1.5</li>
        <li>The Big Lebowski 3.5</li>
        <li>Frantz 3</li>
      </ul>
      <p>Amount owed is 8.0</p>
      <p>You earned 3 frequent renter points</p>
    STATEMENT
    assert_equal expected_html_statement, @customer.html_statement
  end
end
