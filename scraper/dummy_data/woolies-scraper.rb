# 1. scrape product listings on coles.

require "json"
require "open-uri"
require "nokogiri"
require "csv"

# saved details
title = ".product-title-link"
price = ".product-tile-price.primary"
price = ".product-tile-price.secondary" #".price__calculation_method"
card_tile = ".product-tile-v2"
sku_filepath = "top500SKUs-woolies.csv"

list_of_urls = {fruit: "https://www.woolworths.com.au/shop/browse/fruit-veg/fruit",
                veggies: "https://www.woolworths.com.au/shop/browse/fruit-veg/vegetables",
                poultry: "https://www.woolworths.com.au/shop/browse/meat-seafood-deli/poultry",
                meat: "https://www.woolworths.com.au/shop/browse/meat-seafood-deli/meat",
                deli: "https://www.woolworths.com.au/shop/browse/meat-seafood-deli/deli-meats",
                bakery: "https://www.woolworths.com.au/shop/browse/bakery",
                pantry: "https://www.woolworths.com.au/shop/browse/pantry",
                frozen: "https://www.woolworths.com.au/shop/browse/freezer",
                health: "https://www.woolworths.com.au/shop/browse/beauty-personal-care",
                drinks: "https://www.woolworths.com.au/shop/browse/drinks"}

b = "https://www.woolworths.com.au/shop/browse/fruit-veg/fruit"

def scraper(url, idclass)
  scraped_array = []
  html_file = URI.open(url, "User-Agent" => 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Mobile Safari/537.36').read
  html_doc = Nokogiri::HTML.parse(html_file)

  html_doc.search(idclass).each do |element|
    scraped_array << element.text.strip
  end
  scraped_array
end

def save_csv(array, filepath)¸ç
  CSV.open(filepath, "a+") do |csv|
    array.each do |element|
      csv << [element]
    end
  end
end

# price and title
def scraper2(url, idclass)
  scraped_array = []
  # entire_collection = []
  html_file = URI.open(url, "User-Agent" => 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Mobile Safari/537.36').read
  html_doc = Nokogiri::HTML.parse(html_file)

  p html_doc[1]
  elements = html_doc.search(idclass)
  elements.each do |element|
    element.text.strip
  end
  #   p title_tag = element.css(title).text.strip
  #   p price_tag = element.css(price).text.strip
  #   # altered_ptag = price_tag[0..price_tag.length/2-1]
  #   scraped_array << [title_tag, price_tag]
  # end
  scraped_array
end

puts "new line"
p scraper2(b, '.product-title-link')
