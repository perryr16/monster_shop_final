require 'rails_helper'

RSpec.describe 'New Discount' do
  before :each do
    @merchant1 = create(:merchant)
    @m_user = create(:user, name: "merchant user", role: 1, merchant_id: @merchant1.id)
    @discount1 = @merchant1.discounts.create(quantity: 2, percent: 5, name: "5% off 2 items")
    @discount2 = @merchant1.discounts.create(quantity: 5, percent: 20, name: "20% off 5 items")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@m_user)
  end

  it "US3 Discount Index Page" do
    # visit merchant_discounts_path
    visit "/merchant/discounts"
    click_link(@discount1.name)
    # expect(current_path).to eq(merchant_discount_path(@discount1))
    expect(current_path).to eq("/merchant/discounts/#{@discount1.id}")

    within("#discount-#{@discount1.id}")do
      expect(page).to have_content(@discount1.id)
      expect(page).to have_content(@discount1.name)
      expect(page).to have_content(@discount1.percent)
      expect(page).to have_content(@discount1.quantity)
      expect(page).to_not have_content(@discount2.id)
    end

  end
end #final