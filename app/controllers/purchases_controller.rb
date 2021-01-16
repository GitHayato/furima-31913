class PurchasesController < ApplicationController
  before_action :common_content, only: [:index, :create]

  def index
  end

  def create
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
    params.permit(:postal_code, :prefecture_id, :district, :address, :building_name, :phone_number, :item_id)
  end
  
  def common_content
    @item = Item.find(params[:item_id])
  end

end
