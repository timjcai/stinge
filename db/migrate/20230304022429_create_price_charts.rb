class CreatePriceCharts < ActiveRecord::Migration[7.0]
  def change
    create_table :price_charts do |t|
      t.date :date
      t.float :price
      t.references :products, null: false, foreign_key: true

      t.timestamps
    end
  end
end
