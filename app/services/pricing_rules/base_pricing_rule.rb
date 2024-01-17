module PricingRules
    class BasePricingRule
      def apply(product, quantity)
        raise NotImplementedError, "You must implement the apply method in the subclass"
      end
    end
  end
  