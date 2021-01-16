class PurchasesController < ApplicationController
  before_action :common_content, only: [:index, :create]

  def index
  end

  def create
    @address = Address.create(address_params)
    if @address.valid?
      @address.save
      redirect_to root_path
    else
      render :index
    end
    
  end

  private

  def address_params
    params.permit(:postal_code, :prefecture_id, :district, :address, :building_name, :phone_number)
  end
  
  def common_content
    @item = Item.find(params[:item_id])
  end

end
