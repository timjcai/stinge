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
    @storeproduct = []
    p start_date = params[:start_date]&.to_date || Date.today-1.month
    @storeproducts.each do |product|
      pricechart = PriceChart.where(store_product: product)
      counter = 0
      pricechart.each do |pair|
        json = {
          date: pair.date,
          price: pair.price
        }
        if pair.date > start_date
          @storeproduct[counter] = json
          counter += 1
        end
      end
      @allprices[product.brand_name] = @storeproduct
    end
    @allprices
  end
end
