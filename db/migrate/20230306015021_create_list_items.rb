class CreateListItems < ActiveRecord::Migration[7.0]
  def change
    create_table :list_items do |t|
      t.references :lists, null: false, foreign_key: true
      t.references :products, null: false, foreign_key: true
      t.integer :quantity

      t.timestamps
    end
  end
end
