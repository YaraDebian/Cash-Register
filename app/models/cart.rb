class Cart < ActiveRecord::Base
    has_many :cart_items
end