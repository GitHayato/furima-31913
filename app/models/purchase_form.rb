class PurchaseForm
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :district, :address, :building_name, :phone_number, :item_id, :user_id

  with_options presence: true do
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/}
    validates :district
    validates :address
    validates :phone_number, length: { is: 11 }, numericality: true
    validates :prefecture_id
  end

  
  def save
    purchase = Purchase.create(user_id: user_id, item_id: item_id)
    Address.create(postal_code: postal_code, district: district, address: address, building_name: building_name, phone_number: phone_number, prefecture_id: prefecture_id, purchase_id: purchase.id)
  end

end