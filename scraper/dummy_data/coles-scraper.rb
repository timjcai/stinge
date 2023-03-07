# 1. scrape product listings on coles.

require "json"
require "open-uri"
require "nokogiri"
require "csv"

# saved details


title_dom = 'div.sc-219848b8-1.jiBIlJ.coles-targeting-ProductTileHeaderWrapper > header >  div.product__message-title_area > a > h2'


list_of_urls = {fruit: "https://www.coles.com.au/browse/fruit-vegetables?pid=homepage_cat_explorer_fruit_vege&page=1",
                fruit2: "https://www.coles.com.au/browse/fruit-vegetables?pid=homepage_cat_explorer_fruit_vege&page=2",
                fruit3: "https://www.coles.com.au/browse/fruit-vegetables?pid=homepage_cat_explorer_fruit_vege&page=3",
                bakery: "https://www.coles.com.au/browse/bakery?page=1",
                deli: "https://www.coles.com.au/browse/deli",
                pantry: "https://www.coles.com.au/browse/pantry",
                frozen: "https://www.coles.com.au/browse/frozen",
                health: "https://www.coles.com.au/browse/health-beauty",
                drinks: "https://www.coles.com.au/browse/drinks",
                drinks2: "https://www.coles.com.au/browse/drinks?page=2",
                drinks3: "https://www.coles.com.au/browse/drinks?page=3",
                drinks4: "https://www.coles.com.au/browse/drinks?page=4",
                meat: "https://www.coles.com.au/browse/meat-seafood",
                meat2: "https://www.coles.com.au/browse/meat-seafood?page=2",
                meat3: "https://www.coles.com.au/browse/meat-seafood?page=3",
                meat4: "https://www.coles.com.au/browse/meat-seafood?page=4"
              }

# test
# a = 'https://www.coles.com.au/browse/frozen'
# b = 'https://www.coles.com.au/browse/drinks'
# c = 'https://www.coles.com.au/search?q=banana'
# d = 'https://www.coles.com.au/product/coles-shepard-avocados-1-each-5900891'

def scraper(url, idclass)
  scraped_array = []
  html_file = URI.open(url, "User-Agent" => 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Mobile Safari/537.36').read
  html_doc = Nokogiri::HTML.parse(html_file)

  html_doc.search(idclass).each do |element|
    scraped_array << element.text.strip
  end
  scraped_array
end

def save_csv(array, filepath)
  CSV.open(filepath, "a+") do |csv|
    array.each do |element|
      csv << element
    end
  end
end

# save_csv(array, sku_filepath)

# list_of_urls.each_value do |value|
#   save_csv(scraper(value, title), sku_filepath)
#   sleep 5
# end

# price and title
def scraper2(url, idclass, title, price, link)
  scraped_array = []
  # entire_collection = []
  html_file = URI.open(url, "User-Agent" => 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Mobile Safari/537.36').read
  html_doc = Nokogiri::HTML.parse(html_file)

  html_doc.search(idclass).each do |element|
    section_html = []
    title_tag = element.search(title).text.strip
    price_tag = element.search(price).text.strip
    # image_tag = element.css(img).attribute("src").value
    link_tag = element.search(link).attribute("href").value
    altered_ptag = price_tag[0..price_tag.length/2-1]
    scraped_array << [title_tag, altered_ptag, link_tag]
  end
  scraped_array
end

title = ".LinesEllipsis.product__title"
price = ".price__value" #".price__calculation_method"
card_tile = ".sc-219848b8-0.ictfiu"
sku_filepath = "top500SKUs.csv"
image = "[data-testid='product-image']"
link = ".product__link.product__image"

puts "new line"

sku_filepath = 'scraper/coles.csv'

list_of_urls.each_value do |value|
  p save_csv(scraper2(value, card_tile, title, price, link), sku_filepath)
  sleep 2
end
