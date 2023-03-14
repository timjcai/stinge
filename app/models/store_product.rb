class StoreProduct < ApplicationRecord
  belongs_to :product
  has_many :price_charts, dependent: :destroy
end
