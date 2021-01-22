class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :common_content, only: [:show, :update, :edit, :destroy]
  before_action :purchase_item, only: [:show, :edit]


  def index
    @items = Item.includes(:user).order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.create(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
    if current_user.id != @item.user_id or @purchase
      redirect_to root_path
    end
  end

  def update
    if @item.update(item_params)
      redirect_to item_path
    else
      render :edit
    end
  end

  def destroy
    if current_user.id == @item.user_id && @item.destroy
      redirect_to root_path
    else
      render :show
    end
  end

  private

  def item_params
    params.require(:item).permit(:image, :item_name, :explanation, :category_id, :condition_id, :delivery_fee_id, :prefecture_id, :preparation_id, :price).merge(user_id: current_user.id)
  end

  def common_content
    @item = Item.find(params[:id])
  end

  def purchase_item
    @purchase = Purchase.find_by(item_id: @item.id)
  end
end
