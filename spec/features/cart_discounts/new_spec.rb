require 'rails_helper'

RSpec.describe "apply discount in cart" do

  before :each do
    @merchant1 = create(:merchant)
    @merchant2 = create(:merchant)
    @merchant3 = create(:merchant)

    @discount1 = @merchant1.discounts.create(quantity: 5, percent: 50)
    @discount2 = @merchant1.discounts.create(quantity: 3, percent: 10)
    @discount3 = @merchant3.discounts.create(quantity: 1, percent: 90)

    @m_user = create(:user, name: "merchant user", role: 1, merchant_id: @merchant1.id)
    @user = create(:user)

    @item1 = create(:item, price: 10, merchant: @merchant1, inventory: 100)
    @item2 = create(:item, price: 20, merchant: @merchant2)
    @item3 = create(:item, price: 20, merchant: @merchant1)
    @item4 = create(:item, price: 20, merchant: @merchant1)
    @item5 = create(:item, price: 20, merchant: @merchant1)
    @item6 = create(:item, price: 20, merchant: @merchant1)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    
  end

  it "US6 add enough items to triger a discount" do

    visit item_path(@item1)
    click_on "Add to Cart"
    visit item_path(@item2)
    click_on "Add to Cart"
    
    visit cart_path
    
    within("#item-#{@item1.id}")do
      expect(page).to_not have_content("Discount Price: $5.00")
      expect(page).to_not have_content("Subtotal: $5.00 with #{@discount1.name}")

      4.times do
        click_button('More of This!')
      end
      expect(page).to have_content("Quantity: 5")

      expect(page).to have_content("Discount Price: $5.00")
      expect(page).to have_content("Subtotal: $25.00 with discount")
    end
    within("#item-#{@item2.id}")do
      expect(page).to have_content("Subtotal: $20.00")
      expect(page).to_not have_content("Discount")
      expect(page).to_not have_content("discount")
    end

    click_on "Check Out"
    expect(current_path).to eq(profile_orders_path)    
    expect(page).to have_content("Total: $45.00")
  end

  it "US6 having many individual items will not trigger discount" do
    visit item_path(@item1)
    click_on "Add to Cart"
    visit item_path(@item3)
    click_on "Add to Cart"
    visit item_path(@item4)
    click_on "Add to Cart"
    visit item_path(@item5)
    click_on "Add to Cart"
    visit item_path(@item6)
    click_on "Add to Cart"

    visit cart_path

    expect(page).to have_content("Cart: 5")
    expect(page).to_not have_content("Discount")
    expect(page).to_not have_content("discount")

    
  end
  
  
  
end