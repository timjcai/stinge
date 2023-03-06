require 'csv'

filepath = 'data/dummy_data.csv'

#  price
def price_generator
  price_range = (200..700).to_a
  return price_range.sample/100.00
end

# date
def date_array
  start = Date.new(2022,1,1)
  finish = Date.today

  (start.to_date..finish.to_date).map { |date| date.strftime('%y %b %d') }
end

def init_fake_prices(array)
  entry = []
  array.each do |date|
    entry << [date, price_generator]
  end
  entry
end

init_fake_prices(date_array)

# use below if saving to CSV (or testing)


# price_path = "scraper/dummy_data/data/dummy_data.csv"

# def save_csv(filepath, array)
#   CSV.open(filepath, "wb") do |csv|
#     csv << ["index", "price"]
#     array.each do |priceset|
#       csv << priceset
#     end
#   end
# end


# save_csv(price_path, entire_price_dataset)
