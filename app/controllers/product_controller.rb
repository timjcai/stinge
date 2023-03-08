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
    @storeproducts.each do |product|
      pricechart = PriceChart.where(store_product: product)
      counter = 0
      pricechart.each do |pair|
        json = {
          date: pair.date,
          price: pair.price
        }
        @storeproduct[counter] = json
        counter += 1
      end
      @allprices[product.brand_name] = @storeproduct
    end
    @allprices
  end
end
