# 1. scrape product listings on coles.

require "json"
require "open-uri"
require "nokogiri"
require "csv"

# saved details
title = ".LinesEllipsis.product__title"
price = ".price__value" #".price__calculation_method"
card_tile = ".sc-219848b8-0.ictfiu"
sku_filepath = "top500SKUs.csv"

title_dom = 'div.sc-219848b8-1.jiBIlJ.coles-targeting-ProductTileHeaderWrapper > header >  div.product__message-title_area > a > h2'


list_of_urls = {fruit: "https://www.coles.com.au/browse/fruit-vegetables?pid=homepage_cat_explorer_fruit_vege",
                bakery: "https://www.coles.com.au/browse/bakery?page=1",
                deli: "https://www.coles.com.au/browse/deli",
                pantry: "https://www.coles.com.au/browse/pantry",
                frozen: "https://www.coles.com.au/browse/frozen",
                health: "https://www.coles.com.au/browse/health-beauty",
                drinks: "https://www.coles.com.au/browse/drinks",
                meat: "https://www.coles.com.au/browse/meat-seafood"}

a = 'https://www.coles.com.au/browse/frozen'
b = 'https://www.coles.com.au/browse/drinks'

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

# save_csv(array, sku_filepath)

# list_of_urls.each_value do |value|
#   save_csv(scraper(value, title), sku_filepath)
#   sleep 5
# end

# price and title
def scraper2(url, idclass, title, price)
  scraped_array = []
  # entire_collection = []
  html_file = URI.open(url, "User-Agent" => 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Mobile Safari/537.36').read
  html_doc = Nokogiri::HTML.parse(html_file)

  html_doc.search(idclass).each do |element|
    section_html = []
    title_tag = element.css(title).text.strip
    price_tag = element.css(price).text.strip
    altered_ptag = price_tag[0..price_tag.length/2-1]
    scraped_array << [title_tag, altered_ptag]
  end
  scraped_array
end

puts "new line"
p scraper2(b, card_tile, title_dom, price)
