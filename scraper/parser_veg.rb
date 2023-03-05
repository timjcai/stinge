# require "json"
# require "open-uri"
# require "nokogiri"
require "csv"

array = [
  "Fresh Bananas | approx 180g",
  "Coles Hass Avocados | 1 each",
  "Fresh Strawberries Prepacked | 250g",
  "Coles Blueberries Prepacked | 125g",
  "Coles Raspberries | 125g",
  "Coles White Seedless Grapes Loose | approx 800g",
  "Coles Lebanese Cucumbers | approx 210g",
  "Coles Greenhouse Truss Tomatoes | approx 140g",
  "Coles Blackberries | 170g",
  "Coles Red Cherries Loose | approx 400g",
  "Coles Grape Perino Tomatoes Prepacked | 200g",
  "Coles Carrots | Prepacked 1Kg ",
  "Coles Broccoli | approx 340g",
  "Coles Yellow Nectarines | approx 150g",
  "Coles White Nectarines | approx 150g",
  "Coles Honey Gold Mangoes Medium | 1 each",
  "Fresh Brown Onions Loose | approx 180g",
  "Coles Red Capsicum | approx 200g",
  "Coles White Peaches | approx 150g",
  "Coles Seedless Watermelon Cut | approx1.99 kg",
  "Coles Yellow Peaches | approx 150g",
  "Coles Red Onions Loose | approx 200g",
  "Coles Medium Lemons | 1 each",
  "Coles Iceberg Lettuce | 1 each",
  "Coles Brown Onions | 1kg",
  "Coles Continental Cucumbers Loose | 1 each",
  "Coles Sweet Corn Prepacked | 4 pack",
  "Coles Pink Lady Apples | approx 200g",
  "Coles Green Zucchini | approx 260g",
  "Coles Spring Onions | 1 bunch",
  "Coles Sweet Corn | 1 each",
  "Coles Baby Cucumbers | 250g",
  "Fresh Medium Navel Oranges | approx 180g",
  "Coles Carrots Loose | approx 170g",
  "Coles Sweet Gold Potatoes Loose | approx 350g",
  "Coles Kids Pack Bananas | 750g",
  "Coles Lychees Loose | approx 20g",
  "Coles Baby Broccoli | 1 each",
  "Coles Creme Gold Washed Potatoes Loose | approx140g",
  "Coles Fresh Loose Cup Mushrooms | approx 200g",
  "Fresh Granny Smith Medium Apples | approx 170g",
  "Coles Sleeved Herbs Coriander | 1 each",
  "Coles Creme Royale Brushed Potatoes loose | approx 200g",
  "Coles Field Tomatoes Loose | approx 110g",
  "Coles Garlic loose | approx 60g",
  "Coles Roma Tomatoes Loose | approx 100g",
  "Coles Medium Calypso Mangoes | 1 each",
  "Coles Baby Cos Lettuce | 2 pack"
  ]

# p array

filter_1 = []
product = []
weight = []

array.each do |line_item|
  a = line_item.split(" | ")
  product << a[0]
  weight << a[1]
end

# p weight
# p product

brand_less = []

def loose_handler(str)
  if str.include?('Loose')
    a = str.split(" ")
    return a[0..-2].join(" ")
  else
    return str
  end
end

product.each do |item|
  a = item.split(" ")
  brand_less << a[1..-1].join(" ")
end

# p brand_less
# p product
final_product = []

brand_less.each do |item|
  final_product << loose_handler(item)
end

p final_product

filepath = "veggie_names.csv"

def save_csv(array, filepath)
  CSV.open(filepath, "a+") do |csv|
    array.each do |element|
      csv << [element]
    end
  end
end

save_csv(final_product, filepath)
