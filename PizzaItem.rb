class PizzaItem
  attr_accessor :id, :name, :price, :weight, :size, :description

  def initialize(id=0, name="", price=0, weight="", size="",description="")
  	@id=id
  	@name=name
  	@price=price
  	@size=size
  	@weight=weight
  	@description=description
  end
end