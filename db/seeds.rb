# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


# temporary seedfile
require 'csv'


#product generator

filepath = 'scraper/veggie_names.csv'

veg_array = CSV.parse(File.read(filepath)).flatten

def initbatches(array)
  array.each do |item|
    p StoreProduct.create(name: item)
  end
end

# initbatches(veg_array)

# price generator

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

# init_fake_prices(date_array)

# store generator

stores = [
  { company_name: 'Woolworths', location_name: 'Balwyn', address: 'Cnr Whitehorse Road And Mangan Street, Balwyn VIC 3103' },
  { company_name: 'Coles', location_name: 'Balwyn East', address: '342-344 Belmore Rd, Balwyn VIC 3103' },
  { company_name: 'Woolworths', location_name: 'Box Hill Central', address: 'Cnr Main &, Station St, Box Hill VIC 3128' },
  { company_name: 'Coles', location_name: 'Box Hill Central', address: '1 Main St, Box Hill VIC 3128' }
]

def init_store_generator(array)
  array.each do |row|
    Store.create(row)
  end
end

init_store_generator(stores)

# store_product generator
