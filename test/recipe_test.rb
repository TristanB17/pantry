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
end
