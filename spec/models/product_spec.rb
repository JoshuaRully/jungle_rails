require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    
    it 'is valid' do
      @product = Product.new
      @category = Category.new
      @category.name = 'test cat'
      @product.name = 'test prod'
      @product.price_cents = 1000
      @product.quantity = 10
      @product.category = @category
      expect(@product.valid?).to be true
    end

    
  end
end
