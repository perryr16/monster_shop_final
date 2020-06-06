require 'rails_helper'

RSpec.describe 'New Discount' do
  before :each do
    @merchant1 = create(:merchant)
    @m_user = create(:user, name: "merchant user", role: 1, merchant_id: @merchant1.id)
    @discount1 = @merchant1.discounts.create(quantity: 2, percent: 5, name: "5% off 2 items")
    @discount2 = @merchant1.discounts.create(quantity: 20, percent: 50, name: "50% off 20 items")

    visit '/login'
    fill_in :email, with: @m_user.email
    fill_in :password, with: 'p123'
    click_button "Log In"

  end

  it "US5:I merchant can delete a edit discount: index" do
    visit merchant_discounts_path

    expect(page).to have_content(@discount1.id)
    expect(page).to have_content(@discount2.id)

    within("#discount-#{@discount1.id}")do
      click_link("Delete")
    end

    expect(current_path).to eq(merchant_discounts_path)
    expect(page).to have_content("Discount #{@discount1.id} has been deleted")

    expect(page).to_not have_content(@discount1.name)
    expect(page).to have_content(@discount2.id)

  end
  it "US5:II merchant can delete a edit discount: show" do
    visit merchant_discounts_path
    expect(page).to have_content(@discount2.id)
    click_link(@discount1.name)

    within("#discount-#{@discount1.id}")do
      click_link("Delete")
    end

    expect(current_path).to eq(merchant_discounts_path)
    expect(page).to have_content("Discount #{@discount1.id} has been deleted")

    expect(page).to_not have_content(@discount1.name)
    expect(page).to have_content(@discount2.id)

  end
  
end