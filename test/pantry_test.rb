require './lib/pantry'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/recipe'
require 'pry'

class PantryTest < Minitest::Test
  def setup
    @pantry = Pantry.new

    r1 = Recipe.new("Cheese Pizza")
    r1.add_ingredient("Cheese", 20)
    r1.add_ingredient("Flour", 20)
    @r1 = r1

    r2 = Recipe.new("Pickles")
    r2.add_ingredient("Brine", 10)
    r2.add_ingredient("Cucumbers", 30)
    @r2 = r2

    r3 = Recipe.new("Peanuts")
    r3.add_ingredient("Raw nuts", 10)
    r3.add_ingredient("Salt", 10)
    @r3 = r3
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
    @pantry.add_to_shopping_list(recipe)

    assert_equal({"Cheese" => 20, "Flour" => 20}, @pantry.shopping_list)
  end

  def test_pantry_can_add_more_items_to_shopping_list
    recipe_1 = Recipe.new("Cheese Pizza")

    recipe_1.add_ingredient("Cheese", 20)
    recipe_1.add_ingredient("Flour", 20)
    @pantry.add_to_shopping_list(recipe_1)

    recipe_2 = Recipe.new("Spaghetti")

    recipe_2.add_ingredient("Spaghetti Noodles", 10)
    recipe_2.add_ingredient("Marinara Sauce", 10)
    recipe_2.add_ingredient("Cheese", 5)
    @pantry.add_to_shopping_list(recipe_2)

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
    @pantry.add_to_shopping_list(recipe_1)

    recipe_2 = Recipe.new("Spaghetti")

    recipe_2.add_ingredient("Spaghetti Noodles", 10)
    recipe_2.add_ingredient("Marinara Sauce", 10)
    recipe_2.add_ingredient("Cheese", 5)
    @pantry.add_to_shopping_list(recipe_2)

    assert_equal "* Cheese: 25\n* Flour: 20\n* Spaghetti Noodles: 10\n* Marinara Sauce: 10", @pantry.print_shopping_list
  end

  def test_pantry_has_cookbook
    @pantry.add_to_cookbook(@r1)
    @pantry.add_to_cookbook(@r2)
    @pantry.add_to_cookbook(@r3)

    assert_equal 3, @pantry.cookbook.length
    assert_equal @r3, @pantry.cookbook[2]
  end

  def test_pantry_can_determine_what_can_be_made_based_on_stock
    @pantry.add_to_cookbook(@r1)
    @pantry.add_to_cookbook(@r2)
    @pantry.add_to_cookbook(@r3)

    @pantry.restock("Cheese", 10)
    @pantry.restock("Flour", 20)
    @pantry.restock("Brine", 40)
    @pantry.restock("Cucumbers", 120)
    @pantry.restock("Raw nuts", 20)
    @pantry.restock("Salt", 20)

    assert_equal ["Pickles", "Peanuts"], @pantry.what_can_i_make
  end

  def test_pantry_can_find_ingredients_via_recipe_name
    @pantry.add_to_cookbook(@r1)
    @pantry.add_to_cookbook(@r2)
    @pantry.add_to_cookbook(@r3)

    expected = @pantry.find_recipe_by_name("Peanuts")

    assert_equal([{"Raw nuts"=>10, "Salt"=>10}], expected)
  end

  def test_verify_ingredients_determines_number_of_recipes_that_can_be_made
    @pantry.add_to_cookbook(@r1)
    @pantry.add_to_cookbook(@r2)
    @pantry.add_to_cookbook(@r3)

    @pantry.restock("Cheese", 10)
    @pantry.restock("Flour", 20)
    @pantry.restock("Brine", 40)
    @pantry.restock("Cucumbers", 120)
    @pantry.restock("Raw nuts", 20)
    @pantry.restock("Salt", 20)

    how_many = @pantry.verify_ingredients("Peanuts", [{"Raw nuts"=>10, "Salt"=>10}])

    assert_equal 2, how_many
  end

  def test_pantry_can_determine_times_recipes_can_be_made
    @pantry.add_to_cookbook(@r1)
    @pantry.add_to_cookbook(@r2)
    @pantry.add_to_cookbook(@r3)

    @pantry.restock("Cheese", 10)
    @pantry.restock("Flour", 20)
    @pantry.restock("Brine", 40)
    @pantry.restock("Cucumbers", 120)
    @pantry.restock("Raw nuts", 20)
    @pantry.restock("Salt", 20)

    assert_equal({"Pickles" => 4, "Peanuts" => 2}, @pantry.how_many_can_i_make)
  end
end
