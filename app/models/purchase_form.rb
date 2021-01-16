class PurchaseForm
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :district, :address :building_name, :phone_number

  with_options presence: true do
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/}
    validates :district
    validates :address
    validates :phone_number, length: { is: 11 }, numericality: true
    validates :prefecture_id
  end

  
  def save
    user = User.create(nickname: nickname, email: email, :encrypted_password: encrypted_password, first_name: first_name, last_name: last_name, first_name_kana: first_name_kana, last_name_kana: last_name_kana, birthday: birthday)
    item = Item.create(item_name: item_name, explanation: explanation, category_id: category_id, condition_id: condition_id, delivery_fee_id: delivery_fee_id, prefecture_id: prefecture_id, preparation_id: preparation_id, price: price, user_id: user.id)
    purchase = Purchase.create(user_id: user.id, item_id: item.id)
    Address.create(postal_code: postal_code, district: district, address: address, building_name: building_name, phone_number: phone_number, prefecture_id: prefecture_id, purchase_id: purchase.id)
  end

end