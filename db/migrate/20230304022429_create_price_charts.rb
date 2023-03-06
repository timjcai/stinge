class CreatePriceCharts < ActiveRecord::Migration[7.0]
  def change
    create_table :price_charts do |t|
      t.date :date
      t.float :price
      t.references :store_product, null: false, foreign_key: true
      t.integer :measurement
      t.string :measurement_type
      t.string :standard_measurement_ratio

      t.timestamps
    end
  end
end
