class PricingService
    RULES_MAP = {
    'GR1' => PricingRules::GreenTeaBogo.new,
    'SR1' => PricingRules::StrawberriesBulk.new,
    'CF1' => PricingRules::CoffeeAddict.new
  }.freeze

  def self.calculate_total_price(cart_items)
    total_price = BigDecimal('0')

    cart_items.each do |item|
      rule = RULES_MAP[item.product.name]
      total_price += rule ? rule.apply(item.product, item.quantity) : item.product.price * item.quantity
    end
    total_price
  end
end
