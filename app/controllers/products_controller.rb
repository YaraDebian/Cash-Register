class ProductsController < ApplicationController
    def index
        @products = Product.all
        @cart = Cart.first
        @total_price = PricingService.calculate_total_price
    end
end
