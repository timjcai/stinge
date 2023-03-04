class CreateShoppingLists < ActiveRecord::Migration[7.0]
  def change
    create_table :shopping_lists do |t|
      t.string :name
      t.references :user, null: false, foreign_key: true
      t.date :date_created

      t.timestamps
    end
  end
end
