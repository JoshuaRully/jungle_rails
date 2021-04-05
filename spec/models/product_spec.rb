require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    before do
      @product = Product.new
    end
    
    context 'product created' do
      it 'is valid' do
        @category = Category.new
        @category.name = 'test cat'
        @product.name = 'test prod'
        @product.price_cents = 1000
        @product.quantity = 10
        @product.category = @category
        expect(@product.valid?).to be true
      end
    end

    context 'requires name' do
      it "name present" do
        @product.name = nil
        @product.valid?
        expect(@product.errors[:name]).to  include("can't be blank")

        @product.name = 'test'
        @product.valid? 
        expect(@product.errors[:name]).not_to  include("can't be blank")
      end
    end

    context 'requires price' do
      it "price_cents presence" do
        @product.price_cents = nil
        @product.valid?
        expect(@product.errors[:price_cents]).to  include('is not a number')
  
        @product.price_cents = 1000
        @product.valid?
        expect(@product.errors[:price_cents]).not_to  include("can't be blank")
      end
    end
  end
end
