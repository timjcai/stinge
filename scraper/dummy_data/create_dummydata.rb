require 'csv'

filepath = 'data/dummy_data.csv'

price_changes = Array.new
price_range = (200..700).to_a

365.times do
  price_changes << (price_range.sample)/100.00
end

CSV.open(filepath, "wb") do |csv|
  csv << ["index", "price"]
  price_changes.each_with_index do |price, index|
    csv << [index, price]
  end
end
