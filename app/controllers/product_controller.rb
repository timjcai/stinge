class ProductController < ApplicationController
  before_action :set_products, only: %i[find_fruits find_deli find_bakery find_pantry find_frozen find_drinks find_health find_meats]

  def index
    if params[:query].present?
      @products = Product.search_by_product_name(params[:query])
    else
      @products = Product.all
    end
  end

  # def index
  #   if params[:query].present?
  #     sql_query = <<~SQL
  #       products.name @@ :query
  #     SQL
  #     @products = Product.where(sql_query, query: "%#{params[:query]}%")
  #   else
  #     @products = Product.all
  #   end
  # end

  # def index
  #   if params[:query].present?
  #     @products = Product.where(@@, "%#{params[:query]}%")
  #   else
  #     @products = Product.all
  #   end
  # end

  def show
    @product = Product.find(params[:id])
    @storeproducts = StoreProduct.where(product: @product)
    @allprices = create_price_json
  end

  def find_fruits
    @fruits = Product.where(category: 'Fruit & Veggies')
  end

  def find_bakery
    @bakery = Product.where(category: 'Bakery')
  end

  def find_deli
    @deli = Product.where(category: 'Deli')
  end

  def find_pantry
    @pantry = Product.where(category: 'Pantry')
  end

  def find_frozen
    @frozen = Product.where(category: 'Frozen')
  end

  def find_health
    @health = Product.where(category: 'Health & Self Care')
  end

  def find_drinks
    @drinks = Product.where(category: 'Drinks')
  end

  def find_meats
    @meats = Product.where(category: 'Meat & Seafood')
  end

  private

  def set_products
    @products = Product.all
  end

  def create_price_json
    @product = Product.find(params[:id])
    @storeproducts = StoreProduct.where(product: @product)
    @allprices = {}
    p start_date = params[:start_date]&.to_date || Date.today-1.month

    @storeproducts.each do |product|
      @all_store_products = []
      p product
      p pricechart = PriceChart.where(store_product: product)
      counter = 0
      pricechart.each do |pair|
        json = {
          date: pair.date,
          price: pair.price
        }
        if pair.date > start_date
          @all_store_products[counter] = json
          counter += 1
        end
      @allprices[product.brand_name] = @all_store_products
      end
    end
    @allprices
  end
end
