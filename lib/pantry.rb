class Pantry
  attr_reader       :stock,
                    :shopping_list

  def initialize
    @stock = Hash.new(0)
    @shopping_list = Hash.new(0)
  end

  def stock_check(item)
    if @stock[item] != nil
      return @stock[item]
    else
      0
    end
  end

  def restock(item, quantity)
    @stock[item] += quantity
  end

  def add_to_shopping_list(ingredients)
    ingredients.each_pair do |key, value|
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
end
