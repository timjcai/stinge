class CreateStores < ActiveRecord::Migration[7.0]
  def change
    create_table :stores do |t|
      t.string :company_name
      t.string :location_name
      t.string :address

      t.timestamps
    end
  end
end
