require 'rails_helper'

RSpec.describe 'New Discount' do
  before :each do
    @merchant1 = create(:merchant)
    @m_user = create(:user, name: "merchant user", role: 1, merchant_id: @merchant1.id)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@m_user)

  end

  it "US1 merchant can create a new discount" do
    visit new_merchant_discount_path
    expect(current_path).to eq('/merchant/discounts/new')
    save_and_open_page

    within("#new-discount-form")do
      fill_in "discount[quantity]", with: 5
      fill_in "discount[percent]", with: 50

      click_on "Create Discount"
    end

    discount = Discount.last
    expext(discount.quantity).to eq(5)
    expext(discount.percent).to eq(50)

    expect(current_path).to eq(merchant_discounts_path)    
  end
  
end