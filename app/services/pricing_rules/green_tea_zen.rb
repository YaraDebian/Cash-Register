module PricingRules
    class GreenTeaZen < BasePricingRule
      def apply(product, quantity)
        product.price * (quantity / 2 + quantity % 2)
      end
    end
end