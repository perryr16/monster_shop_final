require 'rails_helper'

RSpec.describe 'New Discount' do
  before :each do
    @merchant1 = create(:merchant)
    @merchant_user = create(:user, name: "merchant user", role: 1, merchant_id: @merchant1.id)

    binding.pry
  end

  it "US1 merchant can create a new discount" do
    # visit new_discount_merchant_path(@merchant1)
    
  end
  
end