class Pantry
  attr_reader       :stock,
                    :shopping_list,
                    :cookbook

  def initialize
    @stock = Hash.new(0)
    @shopping_list = Hash.new(0)
    @cookbook = []
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
end
