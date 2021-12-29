require 'csv'
require './PizzaParser.rb'

pizza_parser = PizzaParser.new("https://la.ua/")
pizza_parser.parse
pizza_parser.save