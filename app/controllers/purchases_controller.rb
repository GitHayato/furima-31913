class PurchasesController < ApplicationController
  before_action :common_content, only: [:index, :create]

  def index
    @purchase_form = PurchaseForm.new
  end

  def create
    binding.pry
    @purchase_form = PurchaseForm.new(purchase_params)
    if @purchase_form.valid?
      @purchase_form.save
      redirect_to root_path
    else
      render :index
    end
    
  end

  private

  def purchase_params
    params.require(:purchase_form).permit(:postal_code, :prefecture_id, :district, :address, :building_name, :phone_number, :item_id).merge(user_id: current_user.id, item_id: @item.id)
  end
  
  def common_content
    @item = Item.find(params[:item_id])
  end

end
