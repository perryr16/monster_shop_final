class Merchant::DiscountsController < Merchant::BaseController

  def index 
    @merchant = current_user.merchant
  end

  def show
    @discount = Discount.find(params[:id])
  end
  
  def new
    @merchant = current_user.merchant
    @discount = Discount.new
  end

  def create
    merchant = current_user.merchant
    discount = merchant.discounts.create(discount_params)
    if discount.save
      flash[:success] = "The #{discount.name} discount has been created"
      redirect_to "/merchant/discounts"
    else
      flash[:error] = "Please enter a valid #{missing_params}"
      redirect_to "/merchant/discounts/new"
    end
  end

  def edit
    @merchant = current_user.merchant
    @discount = Discount.find(params[:id])
  end

  def update
    # binding.pry
    discount = Discount.find(params[:id])
    discount.update(discount_params)
    if discount.save
      flash[:success] = "Discount #{discount.id} has been updated"
      # redirect_to merchant_discounts_path
      redirect_to "/merchant/discounts"
    else
      flash[:error] = "Please enter a valid #{missing_params}"
      # redirect_to edit_merchant_discount_path(discount)
      redirect_to "/merchant/discounts/#{discount.id}/edit"
    end
  end
  
  def destroy
    Discount.destroy(params[:id])
    flash[:notice] = "Discount #{params[:id]} has been deleted"
    # redirect_to merchant_discounts_path
    redirect_to "/merchant/discounts"
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