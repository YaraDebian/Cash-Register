class PricingService
    RULES_MAP = {
    'GR1' => PricingRules::GreenTeaZen.new,
    'SR1' => PricingRules::StrawberriesBulk.new,
    'CF1' => PricingRules::CoffeeAddict.new
  }.freeze

  def self.calculate_subtotal_price(cart_item)
    subtotal_price = BigDecimal('0')
    rule = RULES_MAP[cart_item.product.code]
    subtotal_price += rule ? rule.apply(cart_item.product, cart_item.quantity) : cart_item.product.price * cart_item.quantity
    cart_item.subtotal = sprintf('%.2f', subtotal_price)
    cart_item.save
  end

  def self.calculate_total_price(cart)
    CartItem.by_cart(cart.id).map(&:subtotal).sum 
  end
end
