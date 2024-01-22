class CartsController < ApplicationController
  def add_item
    if cart_item.persisted?
        # If the cart_item exists, increment the quantity
        cart_item.quantity += 1
      else
        # If the cart_item is new, set the quantity to 1
        cart_item.quantity = 1
      end
  
    cart_item.save
    PricingService.calculate_subtotal_price(cart_item)
    redirect_to root_path
  end

  def remove_item
    return "Product not added." if cart_item.quantity == 0
    cart_item.quantity -= 1
    cart_item.save
    PricingService.calculate_subtotal_price(cart_item)
    redirect_to root_path
  end

  def cart_item
    @cart_item ||= CartItem.find_or_initialize_by(product_id: params[:product_id], cart_id: params[:id])
  end
end
