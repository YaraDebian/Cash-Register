# BuyMore Cash Register

This document details the implementation and usage of the BuyMore Cash Register application designed to simulate a simple checkout process with the ability to add products to a cart and calculate the total price, including special discount rules.

We started with 3 products (*green tea, strawberry, coffee*) and 3 discount rules, and we added them in a scalable way (more details later)

**Discount 1:** Buy-one-get-one-free offer on green tea.\
**Discount 2:** 2/3 price discount on 3 or more coffees.\
**Discount 3:** Price drop to 4.5€ on 3 or more strawberries.

<img src="/app/assets/images/screenshot.png" alt="buy more"/>

## Installation

Clone the repository with:
```
git clone
```
Make sure you have Ruby and Rails installed:
https://guides.rubyonrails.org/getting_started.html#creating-a-new-rails-project-installing-rails


Once you have it, run the seeds file in your terminal to create your products 🍵☕️🍓 and a new cart 🛒:

 ```bash
rails db:seed
```
Now that your application is filled with some data, start it with:

```bash
rails s -p 3000
```

## Usage

You'll be able to add products to your cart and see the total price in the cart section, also with each cart item subtotal.

|Product..........|Quantity..........|Subtotal|\
|Green tea.......|1.......................|3.11€....|\
|Strawberries_|1.......................|5.00€...|\
|Coffee............|1.......................|11.23€..|
                              Total: 19.34€

### Adding products
You can add more products by adding them to the **/db/seeds.rb** file and running it again:

 ```
Product.create(name: 'Apple 🍎', code: 'AP1', price: 2.0)
```

### Adding discounts
To extend and manage the discount rules in a maintainable way, we used a strategy pattern, where each special discount rule is encapsulated in its class. This way it's easy to add new rules without messing with any existing logic.

_Example: I want to add a 20% discount over each purchase of 5 apples or more._ 💵

All I need to do is create a rule class inside **/app/services/pricing_rules:**

```
module PricingRules
    class AppleParty < BasePricingRule
      def apply(product, quantity)
        quantity >= 5 ? (4 / 5.0) * product.price * quantity : product.price * quantity
      end
    end
end

```
After creating this rule, we need to make sure that it is found and called when we are calculating the subtotal of apples. To do so, we add the apple code to our **RULES_MAP** hash inside the **PricingService**:

```
RULES_MAP = {
...
'AP1' => PricingRules::AppleParty.new
}
```
Later, when we call **rule = RULES_MAP[cart_item.product.code]**, it will know which discount rule we want and it's applied with **rule.apply(product, quantity)**.

## Future improvement opportunities
- Create discount rules with an automation.
- Add an autodiscovery capability to RULES_MAP.

## License

[MIT](https://choosealicense.com/licenses/mit/)