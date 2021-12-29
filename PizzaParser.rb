require 'open-uri'
require 'nokogiri'
require 'csv'
require './PizzaList.rb'
require './PizzaItem.rb'
require 'openssl'

class PizzaParser
    OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE


    def initialize(url)

        @url = url
    end

    def parse
        begin
            html = open(@url) { |result| result.read}
            doc = Nokogiri::HTML(html)

            i = 0
            doc.css('.productThumbnail').each do |element|
                pizza= PizzaItem.new
                pizza.name = element.css("div.productInfoWrapp").css("a").text
                pizza.description = element.css("div.productInfoWrapp").css("p").text
                pizza.price = element.css("div.productInfoWrapp").css("div.productPrice").css("span").text
                pizza.weight = element.css("span.weight").text
                pizza.size = element.css("span.size").text
                pizza.id = i+1
                i= i+1
                PizzaList.set_item(pizza)
            end
        rescue OpenURI::HTTPError => e
            puts e.message
        end
    end

    def save
        path = './pizza_all.csv'
        pizza = PizzaList.get_all
        begin
            File.new(path, "w")
            CSV.open(path, "w", headers: %w[Id Name Price Weight Size Description], write_headers: true) do |csv|
                pizza.each do |product|
                    csv << [product.id, product.name, product.price, product.weight, product.size, product.description]
                end
            end
            puts "Successfully has written in the file"
        rescue StandardError => e
            puts e.message
            puts "Can not open the file for writing"
        end
    end
end