class ProductController < ApplicationController
  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
    @storeproducts = StoreProduct.where(product: @product)
    @allprices = create_price_json
  end

  private

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
