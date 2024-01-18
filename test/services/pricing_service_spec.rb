require 'rails_helper'

RSpec.describe PricingService do
  let(:product_gr1) { Product.create(name: 'Green Tea 🍵', code: 'GR1', price: 3.11) }
  let(:product_sr1) { Product.create(name: 'Strawberries 🍓', code: 'SR1', price: 5.00) }
  let(:product_cf1) { Product.create(name: 'Coffee ☕️', code: 'CF1', price: 11.23) }
  let(:cart) { Cart.create }

  def calculate_subtotal_prices_for(cart_items)
    cart_items.each do |item|
    described_class.calculate_subtotal_price(item)
    end
  end

  describe '.calculate_subtotal_price' do
    let(:cart_item) { CartItem.create(cart_id: cart.id, quantity: 2, product_id: product_gr1.id) }

    it 'calculates subtotal price of green tea using GREENTEAZEN rule' do
      described_class.calculate_subtotal_price(cart_item)

      expect(cart_item.subtotal.to_f).to eq(3.11)
    end
  end
  
  describe '.calculate_total_price' do
    let(:cart_items) {[]}
    before { calculate_subtotal_prices_for(cart_items) }

    context 'Total of GR1, GR1' do
      let(:cart_item) { CartItem.create(cart_id: cart.id, quantity: 2, product_id: product_gr1.id) }
      let(:cart_items) { [cart_item] }

      it 'applies GREENTEAZEN rule and retuns only the price of 1' do
        expect(described_class.calculate_total_price).to eq(3.11)
      end
    end

    context 'Total of SR1,SR1,GR1,SR1' do
      let(:cart_item_1) { CartItem.create(cart_id: cart.id, quantity: 1, product_id: product_gr1.id) }
      let(:cart_item_2) { CartItem.create(cart_id: cart.id, quantity: 3, product_id: product_sr1.id) }
      let(:cart_items) { [cart_item_1, cart_item_2] }

      it 'applies GREENTEAZEN and STRAWBERRYBULK rules' do
        expect(described_class.calculate_total_price.to_f).to eq(16.61)
      end
    end

    context 'Total of GR1,CF1,SR1,CF1,CF1' do
        let(:cart_item_1) { CartItem.create(cart_id: cart.id, quantity: 1, product_id: product_gr1.id) }
        let(:cart_item_2) { CartItem.create(cart_id: cart.id, quantity: 1, product_id: product_sr1.id) }
        let(:cart_item_3) { CartItem.create(cart_id: cart.id, quantity: 3, product_id: product_cf1.id) }
        let(:cart_items) { [cart_item_1, cart_item_2, cart_item_3] } 
  
        it 'applies all three rules' do
          expect(described_class.calculate_total_price.to_f).to eq(30.57)
        end
      end
  end
end