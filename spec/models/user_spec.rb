require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    
    context 'passwords match' do
      user = User.new(
        email: 'test@test.com',
        password: '12345',
        password_confirmation: '12345'
      )
      user.valid?
      it 'matches' do
        expect(user.errors[:password_confirmation]).not_to be_present
      end
    end

    context 'passwords do not match' do
      user = User.new(
        email: 'test@test.com',
        password: '12345',
        password_confirmation: '54321'
      )
      user.valid?
      it 'does not match' do
        expect(user.errors[:password_confirmation]).to be_present
      end
    end

    context 'email is unique' do
      it 'is taken' do
        user1 = User.new(
          email: 'test@test.com',
          password: '12345',
          password_confirmation: '12345'
        )
        user1.save

        user2 = User.new(
          email: 'test@test.com',
          password: '12345',
          password_confirmation: '12345'
        )
        user2.save

        expect(user2.errors[:email].first).to eq('has already been taken')
      end
    end

    context 'password length is valid' do
      it 'is less than five characters' do
        # TODO: find issue w/ password length
        user = User.new(
          email: 'bob@test.com',
          password: '1234',
          password_confirmation: '1234'
        )
        result = user.save
        expect(result).to be(false)
      end
    end

    
  end
end
