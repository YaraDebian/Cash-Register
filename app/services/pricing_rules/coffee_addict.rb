module PricingRules
    class CoffeeAddict < BasePricingRule
      def apply(product, quantity)
        quantity >= 3 ? (2 / 3.0) * product.price * quantity : product.price * quantity
      end
    end
end