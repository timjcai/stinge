require "json"
require "open-uri"
require "nokogiri"
require "csv"

filepath = "scraper/dummy_data/coles-pagelinks.csv"



def load_csv(filepath)
  return_array = []
  CSV.foreach(filepath) do |row|
    return_array << row.join
  end
  return_array
end

p coles_pagelinks = load_csv(filepath)[1..-1]

image = "[data-testid='product-image-0']"
test1 = "https://www.coles.com.au/product/fresh-bananas-approx.-180g-each-409499"

def image_scraper(url, id)
  html_file = URI.open(url, "User-Agent" => 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Mobile Safari/537.36').read
  html_doc = Nokogiri::HTML.parse(html_file)
  scraped_array = []

  html_doc.search(id).each do |element|
    scraped_array << element.attribute("src").value
  end
  scraped_array[1]
end

filepath2 ="scraper/dummy_data/coles-pagelinks-parsed.csv"
links = []


def save_csv(array, filepath)
  CSV.open(filepath, "wb") do |csv|
    csv << ['Link', 'Image_Link']
    array.each do |link|
      p csv << [link, image_scraper(link, "[data-testid='product-image-0']")]
      sleep 2
    end
  end
end

save_csv(coles_pagelinks, filepath2)
