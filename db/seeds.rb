# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


# temporary seedfile
require 'csv'

#new user

p User.create(email: 'test@gmail.com', password: '123456')
p List.create(name: 'test_list', user_id: 1)

#product generator

filepath = 'scraper/product_names.csv'

product_array = CSV.parse(File.read(filepath))



def initproducts(array)
  array.each do |item|
    p Product.create(name: item[0], category: item[1])
  end
end

initproducts(product_array)

# price generator

def price_generator
  price_range = (200..700).to_a
  return price_range.sample / 100.00
end

# date
def date_array
  # start = Date.new(2022, 10, 1)
  p start = Date.today.prev_month(3)
  finish = Date.today

  (start.to_date..finish.to_date).map { |date| date.strftime('%b %d %Y') }
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
  { company_name: 'Coles', location_name: 'Balwyn East', address: '342-344 Belmore Rd, Balwyn VIC 3103' }
  # { company_name: 'Woolworths', location_name: 'Box Hill Central', address: 'Cnr Main &, Station St, Box Hill VIC 3128' },
  # { company_name: 'Coles', location_name: 'Box Hill Central', address: '1 Main St, Box Hill VIC 3128' }
]

def init_store_generator(array)
  array.each do |row|
    p Store.create(row)
  end
end

init_store_generator(stores)

# store_product generator

def init_store_product_generator(array)
  all_sproducts = []
  array.each do |item|
    product_sproducts = []
    p product = Product.find_by(name: item)
    brand_name = ['Coles', 'Woolworths']
    brand_name.each do |brand|
      if brand == 'Coles'
        id = Store.find_by(id: 2)
        product_sproducts << StoreProduct.create(brand_name: brand, product_name: item, product: product, store: id)
      else
        id = Store.find_by(id: 1)
        product_sproducts << StoreProduct.create(brand_name: brand, product_name: item, product: product, store: id)
      end
    end
    all_sproducts << product_sproducts
    # p storeproduct1 = StoreProduct.create(brand_name: "Coles", product_name: item, product: product)
    # p storeproduct2 = StoreProduct.create(brand_name: "Woolworths", product_name: item, product: product)
    # prices = init_fake_prices(date_array)
    # prices2 = init_fake_prices(date_array)
    # prices.each do |set|
    #   date = set[0]
    #   price_set = set[1]
    #   p PriceChart.create(date: date, price: price_set, store_product: storeproduct1, measurement: 100, measurement_type: 'g', standard_measurement_ratio: '100g')
    # end
    # prices2.each do |set|
    #   date = set[0]
    #   price_set = set[1]
    #   p PriceChart.create(date: date, price: price_set, store_product: storeproduct2, measurement: 100, measurement_type: 'g', standard_measurement_ratio: '100g')
    # end
  end
  p all_sproducts.flatten
end

def init_product_prices(array)
  array.each do |storeproduct|
    prices = init_fake_prices(date_array)
    prices.each do |set|
      date = set[0]
      price_set = set[1]
      p PriceChart.create(date: date, price: price_set, store_product: storeproduct, measurement: 100, measurement_type: 'g', standard_measurement_ratio: '100g')
    end
  end
end

# test_aray = ['Bananas', 'Hass Avocados']

all_sproducts = init_store_product_generator(product_array)

p init_product_prices(all_sproducts)
