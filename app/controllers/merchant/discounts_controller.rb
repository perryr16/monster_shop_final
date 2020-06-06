class Merchant::DiscountsController < Merchant::BaseController
  def new
    @merchant = current_user.merchant
    @discount = @merchant.discounts.new
  end

end