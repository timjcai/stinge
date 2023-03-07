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
    @allprices = []
    @storeproduct = []
    @storeproducts.each do |product|
      pricechart = PriceChart.where(store_product: product)
      counter = 0
      pricechart.each do |pair|
        json = {}
        json['date'] = pair.date
        json['price'] = pair.price
        p @storeproduct[counter] = json
        counter += 1
      end
      @allprices << @storeproduct
    end
    @allprices
  end
end
