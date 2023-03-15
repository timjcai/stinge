class PriceChart < ApplicationRecord
  belongs_to :store_product
  belongs_to :product
end
