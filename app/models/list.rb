class List < ApplicationRecord
  belongs_to :user
  has_many :list_items

  def has_product?(product)
    list_items.any? { |list_item| list_item.product_id == product.id }
  end
end
