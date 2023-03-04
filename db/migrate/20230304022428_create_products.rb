class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :brand_name
      t.string :product_name
      t.integer :weight
      t.string :weight_type
      t.references :batch, null: false, foreign_key: true

      t.timestamps
    end
  end
end
