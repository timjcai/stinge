require "json"
require "open-uri"
require "nokogiri"
require "csv"

url = "https://postcodes-australia.com/state-postcodes/vic"
idclass = ""

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

p scraper(url, "li")
