require 'rails_helper'

RSpec.describe 'New Discount' do
  before :each do
    @merchant1 = create(:merchant)
    @m_user = create(:user, name: "merchant user", role: 1, merchant_id: @merchant1.id)
    @discount1 = @merchant1.discounts.create(quantity: 2, percent: 5, name: "5% off 2 items")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@m_user)
  end

  it "US4:I merchant can create a edit discount: success" do
    visit "/merchant/discounts/#{@discount1.id}/edit"

    within("#edit-discount-#{@discount1.id}")do
      fill_in "discount[quantity]", with: 10
      fill_in "discount[percent]", with: 15

      click_on "Update Discount"
    end
    @discount1.reload

    expect(@discount1.quantity).to eq(10)
    expect(@discount1.percent).to eq(15)
    expect(@discount1.name).to eq("15% off 10 items")

    expect(current_path).to eq(merchant_discounts_path) 
    expect(page).to have_content("Discount #{@discount1.id} has been updated")   
  end

  it "US4:II mechant can edit a discount: failure" do

    visit "/merchant/discounts/#{@discount1.id}/edit"

    within("#edit-discount-#{@discount1.id}")do
      fill_in "discount[quantity]", with: ""
      fill_in "discount[percent]", with: ""

      click_on "Update Discount"
    end

    expect(current_path).to eq("/merchant/discounts/#{@discount1.id}/edit") 
    expect(page).to have_content("Please enter a valid quantity, percent")   

    within("#edit-discount-#{@discount1.id}")do
      fill_in "discount[quantity]", with: 10
      fill_in "discount[percent]", with: ""

      click_on "Update Discount"
    end

    expect(current_path).to eq("/merchant/discounts/#{@discount1.id}/edit") 
    expect(page).to have_content("Please enter a valid percent")   
  end

  it "links to edit from show and index" do
    visit "/merchant/discounts"
    within("#discount-#{@discount1.id}")do
      click_link("Edit") 
    end
    expect(current_path).to eq("/merchant/discounts/#{@discount1.id}/edit")
    
    visit "/merchant/discounts/#{@discount1.id}"
    within("#discount-#{@discount1.id}")do
      click_link("Edit") 
    end
    expect(current_path).to eq("/merchant/discounts/#{@discount1.id}/edit")
    
  end
  

  
  
end