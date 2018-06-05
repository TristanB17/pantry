class Pantry
  attr_reader       :stock,
                    :shopping_list,
                    :cookbook,
                    :how_much

  def initialize
    @stock = Hash.new(0)
    @shopping_list = Hash.new(0)
    @cookbook = []
    @how_much = {}
  end

  def stock_check(item)
    if @stock[item] != nil
        @stock[item]
    end
  end

  def restock(item, quantity)
    @stock[item] += quantity
  end

  def add_to_shopping_list(recipe)
    recipe.ingredients.each_pair do |key, value|
      @shopping_list[key] += value
    end
  end

  def print_shopping_list
    list = []
    @shopping_list.each_pair do |key, value|
      list << "* #{key}: #{value}"
    end
    list.join("\n")
  end

  def add_to_cookbook(recipe)
    @cookbook << recipe
  end

  def what_can_i_make
    to_make = []
    @cookbook.each do |recipe|
      if check_ingredients(recipe)
        to_make << recipe.name
      end
    end
    to_make
  end

  def check_ingredients(recipe)
    enough = []
    recipe.ingredients.each_pair do |key, value|
      if stock_check(key) > value
        enough << key
      end
    end
    recipe.ingredients.values.count == enough.count
  end

  def find_recipe_by_name(name)
    ingredients = []
    @cookbook.each do |recipe|
      if recipe.name == name
        ingredients << recipe.ingredients
      end
    end
    verify_ingredients(name, ingredients)
  end

  def how_many_can_i_make
    check = what_can_i_make.map do |recipe|
      find_recipe_by_name(recipe)
    end
    @how_much
  end

  def verify_ingredients(name, ingredients)
    how_many = []
    ingredients[0].each_pair do |key, value|
      how_many << stock_check(key) / value
    end
    final_hash(name, how_many.min)
  end

  def final_hash(name, how_many)
    @how_much[name] = how_many
    @how_much
  end
end
