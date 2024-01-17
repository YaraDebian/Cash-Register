class CartsController < ApplicationController
    def show
        @cart = Cart.first # This can be fetched later by user_id
    end

    def add_item

    end
end
