class PriceChartController < ApplicationController
  def show
    @pricechart = PriceChart.find(params[:id])
  end
end
