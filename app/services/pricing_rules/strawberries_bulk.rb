module PricingRules
    class StrawberriesBulk < BasePricingRule
      DISCOUNT_PRICE = BigDecimal('4.50')
  
      def apply(product, quantity)
        quantity >= 3 ? DISCOUNT_PRICE * quantity : product.price * quantity
      end
    end
end