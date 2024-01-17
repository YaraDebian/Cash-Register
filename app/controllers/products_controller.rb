class ProductsController < ApplicationController
    def index
        @products = Product.all
    end

    # def create
    # end

    # def delete
    # end
end
