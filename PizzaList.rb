require "./PizzaItem.rb"

class PizzaList
  @@pizza=[]

  def self.set_item(item)
  	@@pizza.push(item)
  end

  def self.get_all
    @@pizza
  end
end