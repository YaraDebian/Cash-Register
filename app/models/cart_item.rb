class CartItem < ActiveRecord::Base
    belongs_to :cart
    belongs_to :product

    scope :by_cart, ->(cart_id) { where(cart_id: cart_id) }
end