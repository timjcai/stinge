class AddStoreIDtoPriceCharts < ActiveRecord::Migration[7.0]
  def change
    add_reference :price_charts, :stores, foreign_key: true
  end
end
