class ProductController < ApplicationController
  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
    @storeproducts = StoreProduct.where(product: @product)
    p create_price_json
  end

  private

  def create_price_json
    @product = Product.find(params[:id])
    @storeproducts = StoreProduct.where(product: @product)
    @allprices = []
    @storeproduct = []
    json = {}
    @storeproducts.each do |product|
      pricechart = PriceChart.where(store_product: product)
      pricechart.each do |pair|
        json[pair.date] = pair.price
      end
      @allprices << json
    end
    @allprices
  end
end
