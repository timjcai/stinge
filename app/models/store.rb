class Store < ApplicationRecord
  has_many :store_products, dependent: :destroy
  has_many :products, through: :store_products

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
