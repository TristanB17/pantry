require './lib/pantry'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/recipe'
require 'pry'

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

  def test_pantry_has_a_shopping_list
    recipe = Recipe.new("Cheese Pizza")

    assert_equal({}, @pantry.shopping_list)

    recipe.add_ingredient("Cheese", 20)
    recipe.add_ingredient("Flour", 20)
    @pantry.add_to_shopping_list(recipe.ingredients)

    assert_equal({"Cheese" => 20, "Flour" => 20}, @pantry.shopping_list)
  end

  def test_pantry_can_add_more_items_to_shopping_list
    recipe_1 = Recipe.new("Cheese Pizza")

    recipe_1.add_ingredient("Cheese", 20)
    recipe_1.add_ingredient("Flour", 20)
    @pantry.add_to_shopping_list(recipe_1.ingredients)

    recipe_2 = Recipe.new("Spaghetti")

    recipe_2.add_ingredient("Spaghetti Noodles", 10)
    recipe_2.add_ingredient("Marinara Sauce", 10)
    recipe_2.add_ingredient("Cheese", 5)
    @pantry.add_to_shopping_list(recipe_2.ingredients)

    assert_equal({
      "Cheese" => 25,
      "Flour" => 20,
      "Spaghetti Noodles" => 10,
      "Marinara Sauce" => 10
      }, @pantry.shopping_list)
  end

  def test_pantry_can_print_shopping_list
    recipe_1 = Recipe.new("Cheese Pizza")

    recipe_1.add_ingredient("Cheese", 20)
    recipe_1.add_ingredient("Flour", 20)
    @pantry.add_to_shopping_list(recipe_1.ingredients)

    recipe_2 = Recipe.new("Spaghetti")

    recipe_2.add_ingredient("Spaghetti Noodles", 10)
    recipe_2.add_ingredient("Marinara Sauce", 10)
    recipe_2.add_ingredient("Cheese", 5)
    @pantry.add_to_shopping_list(recipe_2.ingredients)

    assert_equal "* Cheese: 25\n* Flour: 20\n* Spaghetti Noodles: 10\n* Marinara Sauce: 10", @pantry.print_shopping_list
  end

end
