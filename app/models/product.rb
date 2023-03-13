class Product < ApplicationRecord
  has_many :list_items

  include PgSearch::Model


  pg_search_scope :search_by_product_name,
    against: [ :name ],
    using: {
      tsearch: { prefix: true } # <-- so `baby carro` will return something
    }
end
