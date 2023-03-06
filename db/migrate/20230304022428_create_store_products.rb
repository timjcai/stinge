class CreateStoreProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :store_products do |t|
      t.string :brand_name
      t.string :product_name
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
