class ProductsController < ApplicationController
    def index
        @products = Product.all
        @cart = Cart.first # Ideally get cart by user_id 
        @total_price = PricingService.calculate_total_price(@cart)
    end
end
