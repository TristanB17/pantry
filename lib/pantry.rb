class Pantry
  attr_reader       :stock

  def initialize
    @stock = Hash.new(0)
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

end
