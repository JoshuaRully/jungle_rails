require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    before do
      @product = Product.new
      @category = Category.new
      @category.name = 'test category'
      @product.name = 'test product'
      @product.price_cents = 1000
      @product.quantity = 10
      @product.category = @category
    end

    context 'requires name' do
      it 'has name' do
        @product.name = nil
        @product.valid?
        expect(@product.errors[:name]).to  include("can't be blank")

        @product.name = 'test'
        @product.valid? 
        expect(@product.errors[:name]).not_to  include("can't be blank")
      end
    end

    context 'requires price' do
      it 'has price_cents' do
        @product.price_cents = nil
        @product.valid?
        expect(@product.errors[:price_cents]).to  include('is not a number')
  
        @product.price_cents = 1000
        @product.valid?
        expect(@product.errors[:price_cents]).not_to  include("can't be blank")
      end
    end

    context 'requires quantity' do
      it 'has quantity' do
        @product.quantity = nil
        @product.valid?
        expect(@product.errors[:quantity]).to include("can't be blank")

        @product.quantity = 10
        @product.valid?
        expect(@product.errors[:quantity]).not_to include("can't be blank")
      end
    end

    context 'requires category' do
      it 'has category' do
        @product.category = nil
        @product.valid?
        expect(@product.errors[:category]).to include("can't be blank")

        @product.category = @category
        @product.valid? 
        expect(@product.errors[:category]).not_to  include("can't be blank")
      end
    end

  end
end
