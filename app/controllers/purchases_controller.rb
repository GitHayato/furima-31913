class PurchasesController < ApplicationController
  before_action :authenticate_user!, only: :index
  before_action :common_content, only: [:index, :create]

  def index
    purchase = Purchase.find_by(item_id: @item.id)
    if @item.user_id == current_user.id or purchase 
      redirect_to root_path
    else
      @purchase_form = PurchaseForm.new
    end
  end

  def create
    @purchase_form = PurchaseForm.new(purchase_params)
    if @purchase_form.valid?
      pay_item
      @purchase_form.save
      redirect_to root_path 
    else
      render :index
    end
    
  end

  private

  def purchase_params
    params.require(:purchase_form).permit(:postal_code, :prefecture_id, :district, :address, :building_name, :phone_number, :item_id).merge(user_id: current_user.id, item_id: @item.id, token: params[:token])
  end
  
  def common_content
    @item = Item.find(params[:item_id])
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: purchase_params[:token],
      currency: 'jpy'
    )
  end

end
