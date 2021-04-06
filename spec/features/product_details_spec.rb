
require 'rails_helper'

RSpec.feature "Visitor navigates to product details", type: :feature, js: true do

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'
    @category.products.create!(
      name:  Faker::Hipster.sentence(3),
      description: Faker::Hipster.paragraph(4),
      image: open_asset('apparel1.jpg'),
      quantity: 10,
      price: 64.99
    )
  end

  scenario "They see product name" do
    # ACT
    visit root_path

    # VERIFY
    find('a.btn-default').click

    expect(page).to have_content('Name')
    
    # DEBUG
    # save_screenshot
  end
end