class CreateLists < ActiveRecord::Migration[7.0]
  def change
    create_table :lists do |t|
      t.string :name
      t.references :user, null: false, foreign_key: true
      t.date :date_created
      t.boolean :active

      t.timestamps
    end
  end
end
