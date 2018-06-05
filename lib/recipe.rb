class Recipe
  attr_reader       :name,
                    :ingredients

  def initialize(name)
    @name = name
    @ingredients = Hash.new(0)
  end

  def add_ingredient(item, quantity)
    @ingredients[item] += quantity
  end
end
