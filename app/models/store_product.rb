class StoreProduct < ApplicationRecord
  belongs_to :product
  belongs_to :store

  has_many :price_charts, dependent: :destroy
end
