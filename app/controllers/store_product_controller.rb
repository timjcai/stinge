class StoreProductController < ApplicationController
  def show
    @storeproduct = StoreProduct.find(params[:id])
    @pricechart = PriceChart.where(store_product: @storeproduct )
  end
end
