# encoding: UTF-8

CartItem.destroy_all
Product.destroy_all
Cart.destroy_all

Product.create(name: 'Green Tea 🍵', code: 'GR1', price: 3.11)
Product.create(name: 'Strawberries 🍓', code: 'SR1', price: 5.00)
Product.create(name: 'Coffee ☕️', code: 'CF1', price: 11.23)
Cart.create

