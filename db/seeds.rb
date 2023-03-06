# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


# temporary seedfile
require 'csv'
require 'scraper/dummy_data/create_dummydata'



filepath = 'scraper/veggie_names.csv'

veg_array = CSV.parse(File.read(filepath)).flatten

def initbatches(array)
  array.each do |item|
    p StoreProduct.create(name: item)

  end
end

initbatches(veg_array)
