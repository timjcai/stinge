class StoreLocatorController < ApplicationController
  def index
    @postcode = params[:postcode] || 3000
    @stores = Store.all.geocoded.near("#{@postcode} Australia", 20)
    @markers = @stores.map do |store|
      {
        lat: store.latitude,
        lng: store.longitude
      }
    end
  end
end
