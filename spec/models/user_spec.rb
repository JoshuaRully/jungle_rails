require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'is valid' do
      user = User.new(
        first_name: 'john',
        last_name: 'smith',
        email: 'john@test.com',
        password: '12345',
        password_confirmation: '12345'
      )
      expect(user).to be_valid
    end

    it 'has no email' do
      user = User.new(email: nil)
      expect(user).to be_invalid
      expect(user.errors[:email]).to include("can't be blank")
  
      user.email = 'test@test.com'
      user.valid?
      expect(user.errors[:email]).not_to include("can't be blank")
    end

    it 'has no first name' do
      user = User.new(first_name: nil)
      expect(user).to be_invalid
      expect(user.errors[:first_name]).to include("can't be blank")
  
      user.first_name = 'john'
      user.valid? 
      expect(user.errors[:first_name]).not_to include("can't be blank")
    end

    it 'has no last name' do
      user = User.new(last_name: nil)
      expect(user).to be_invalid
      expect(user.errors[:last_name]).to include("can't be blank")
  
      user.last_name = 'smith'
      user.valid? 
      expect(user.errors[:last_name]).not_to include("can't be blank")
    end

    it 'mismatched passwords' do
      user = User.new(
        first_name: 'john',
        last_name: 'smith',
        email: 'john@test.com',
        password: '12345',
        password_confirmation: '123456'
      )
      user.valid?
      expect(user.errors[:password_confirmation]).to be_present
    end

    it 'has uniqiue email' do
      user1 = User.new
      user1.first_name = 'john'
      user1.last_name = 'smith'
      user1.email = 'john@test.com'
      user1.password = '12345'
      user1.password_confirmation = '12345'

      user1.save
    
      user2 = User.new
      user2.first_name = 'john'
      user2.last_name = 'doe'
      user2.email = 'john@test.com'
      user2.password = '54321'
      user2.password_confirmation = '54321'
      user2.save
    
      expect(user2.errors[:email].first).to eq('has already been taken')
    end

    it 'has password with less than 5 characters' do
      user = User.new
      user.first_name = 'john'
      user.last_name = 'smith'
      user.email = 'john@test.com'
      user.password = '1234'
      user.password_confirmation = '1234'
      expect(user).to be_invalid
    end

    it 'has password with 5 characters' do
      user = User.new
      user.first_name = 'john'
      user.last_name = 'smith'
      user.email = 'john@test.com'
      user.password = '12345'
      user.password_confirmation = '12345'
      expect(user).to be_valid
    end
  end
  
  describe '.authenticate_with_credentials' do
    it 'will pass with valid credentials' do
      user = User.new(
        first_name: 'john',
        last_name: 'smith',
        email: 'john@test.com',
        password: '12345',
        password_confirmation: '12345'
      )
      user.save

      user = User.authenticate_with_credentials('john@test.com', '12345')
      expect(user).not_to be(nil)
    end

    it 'will not pass with invalid credentials' do
      user = User.new(
        first_name: 'john',
        last_name: 'smith',
        email: 'john@test.com',
        password: '12345',
        password_confirmation: '12345'
      )
      user.save

      user = User.authenticate_with_credentials('john@test.com', '123456')
      expect(user).to be(nil)
    end

    it 'will pass with spaces present in email' do
      user = User.new(
        first_name: 'john',
        last_name: 'smith',
        email: 'john@test.com',
        password: '12345',
        password_confirmation: '12345'
      )
      user.save

      user = User.authenticate_with_credentials('  john@test.com  ', '12345')
      expect(user).not_to be(nil)
    end

    it 'will pass with caps present in email' do
      user = User.new(
        first_name: 'john',
        last_name: 'smith',
        email: 'john@test.com',
        password: '12345',
        password_confirmation: '12345'
      )
      user.save

      user = User.authenticate_with_credentials('joHn@TeSt.com', '12345')
      expect(user).not_to be(nil)
    end
  end
end