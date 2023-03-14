class ListItem < ApplicationRecord
  belongs_to :list
  belongs_to :product

  validates :list_id, :uniqueness => {:scope => :product_id}
end
