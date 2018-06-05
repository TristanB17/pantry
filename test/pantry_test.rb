require './lib/pantry'
require 'minitest/autorun'
require 'minitest/pride'

class PantryTest < Minitest::Test
  def setup
    @pantry = Pantry.new
  end

  def test_pantry_exists
    assert_instance_of Pantry, @pantry
  end

  def test_pantry_has_attributes
    assert_equal({}, @pantry.stock)
  end

  def test_pantry_can_check_stock
    assert_equal 0, @pantry.stock_check("Cheese")
  end

  def test_pantry_can_restock_items
    assert_equal 0, @pantry.stock["Cheese"]

    @pantry.restock("Cheese", 10)

    assert_equal 10, @pantry.stock_check("Cheese")

    @pantry.restock("Cheese", 20)

    assert_equal 30, @pantry.stock["Cheese"]
  end

end
