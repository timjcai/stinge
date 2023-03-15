class AddStoreIdtoStoreProducts < ActiveRecord::Migration[7.0]
  def change
    add_reference :store_products, :store, foreign_key: true, null: false
  end
end
