require 'rails_helper'

RSpec.describe 'New Discount' do
  before :each do
    @merchant1 = create(:merchant)
    @m_user = create(:user, name: "merchant user", role: 1, merchant_id: @merchant1.id)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@m_user)
  end

  it "US1:I merchant can create a new discount success" do
    visit new_merchant_discount_path
    expect(current_path).to eq('/merchant/discounts/new')

    within("#new-discount-form")do
      fill_in "discount[quantity]", with: 5
      fill_in "discount[percent]", with: 50

      click_on "Create Discount"
    end

    discount = Discount.last
    expect(discount.quantity).to eq(5)
    expect(discount.percent).to eq(50)
    expect(discount.name).to eq("50% off 5 items")

    expect(current_path).to eq(merchant_discounts_path) 
    expect(page).to have_content("The #{discount.name} discount has been created")   
  end

  it "US1:II merchant can't create discount if bad or missing fields" do

    visit new_merchant_discount_path
    expect(current_path).to eq('/merchant/discounts/new')

    within("#new-discount-form")do
      fill_in "discount[quantity]", with: ""
      fill_in "discount[percent]", with: ""

      click_on "Create Discount"
    end
    expect(current_path).to eq(new_merchant_discount_path) 
    expect(page).to have_content("Please enter a valid quantity, percent")

    expect(current_path).to eq(new_merchant_discount_path) 
    expect(page).to have_content("Please enter a valid quantity, percent")

    within("#new-discount-form")do
      fill_in "discount[quantity]", with: 5
      fill_in "discount[percent]", with: ""

      click_on "Create Discount"
    end
    expect(current_path).to eq(new_merchant_discount_path) 
    expect(page).to have_content("Please enter a valid percent")

    within("#new-discount-form")do
      fill_in "discount[quantity]", with: 5
      fill_in "discount[percent]", with: 50

      click_on "Create Discount"
    end
    discount = Discount.last
    expect(current_path).to eq(merchant_discounts_path) 
    expect(page).to have_content("The #{discount.name} discount has been created")   
    
  end
  
  
end