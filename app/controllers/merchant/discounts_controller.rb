class Merchant::DiscountsController < Merchant::BaseController

  def index 
    @merchant = current_user.merchant
  end
  
  def new
    @merchant = current_user.merchant
    @discount = @merchant.discounts.new
  end

  def create
    merchant = current_user.merchant
    discount = merchant.discounts.create(discount_params)
    if discount.save
      flash[:success] = "The #{discount.name} discount has been created"
      redirect_to merchant_discounts_path
    else
      flash[:error] = "Please enter a valid #{missing_params}"
      redirect_to new_merchant_discount_path
    end
  end

  private

  def discount_params
    name_generator
    params.require(:discount).permit(:name, :quantity, :percent)
  end
  
  def name_generator
    params[:discount][:name] = "#{params[:discount][:percent]}% off #{params[:discount][:quantity]} items"
  end

  def missing_params
    missing_params = []
    params[:discount].each do |key, value|
        missing_params << key if value == ""
    end
    missing_params.join(", ")
  end
  
  
  

end