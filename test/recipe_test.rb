require './lib/recipe'
require './lib/pantry'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'

class RecipeTest < Minitest::Test
  def test_recipe_exists
    recipe = Recipe.new("Cheese Pizza")

    assert_instance_of Recipe, recipe
  end

  def test_recipe_has_attributes
    recipe = Recipe.new("Cheese Pizza")

    assert_equal "Cheese Pizza", recipe.name
    assert_equal({}, recipe.ingredients)
  end

  def test_recipe_can_add_ingredients
    recipe = Recipe.new("Cheese Pizza")

    recipe.add_ingredient("Cheese", 20)
    recipe.add_ingredient("Flour", 20)

    assert_equal 20, recipe.ingredients["Cheese"]
    assert_equal 20, recipe.ingredients["Flour"]
    assert_equal({"Cheese" => 20, "Flour" => 20}, recipe.ingredients)
  end
end
