# 1. scrape product listings on coles.

require "json"
require "open-uri"
require "nokogiri"
require "csv"


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
def scraper2(url, idclass, title, price)
  scraped_array = []
  # entire_collection = []
  html_file = URI.open(url, "User-Agent" => 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Mobile Safari/537.36').read
  html_doc = Nokogiri::HTML.parse(html_file)

  html_doc.search(idclass).each do |element|
    section_html = []
    p title_tag = element.search(title).text.strip
    price_tag = element.search(price).text.strip
    # image_tag = element.css(img).attribute("src").value
    link_tag = element.search(title).attribute("href").value
      altered_ptag = price_tag[0..price_tag.length/2-1]
      scraped_array << [title_tag, altered_ptag, link_tag]
  end
  scraped_array
end

# saved details
title = ".product-title-link"
price = ".product-tile-price.primary"
price_ratio = ".product-tile-price.secondary" #".price__calculation_method"
card_tile = ".product-tile-v2"
sku_filepath = "top500SKUs-woolies.csv"
# link = href of title tag

puts "new line"

sku_filepath = 'scraper/coles.csv'

b = "https://www.woolworths.com.au/shop/browse/fruit-veg/fruit"


p scraper(b, title)
# p scraper2(b, card_tile, title, price)

# list_of_urls.each_value do |value|
#   p save_csv(scraper2(value, card_tile, title, price, link), sku_filepath)
#   sleep 2
# end
