class Product < ApplicationRecord
  has_many :list_items, dependent: :destroy
  has_many :store_products, dependent: :destroy
  has_many :price_charts, through: :store_products
  has_many :stores, through: :store_products
  has_one_attached :photo

  include PgSearch::Model
  pg_search_scope :search_by_product_name,
    against: [ :name ],
    using: {
      tsearch: { prefix: true } # <-- so `baby carro` will return something
    }
end
