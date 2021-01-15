class Purchase
  include ActiveModel::Model
  attr_accessor :nickname, :email, :encrypted_password, :first_name, :last_name, :first_name_kana, :last_name_kana, :birthday, :image, :item_name, :explanation, :condition_id, :category_id, :delivery_fee_id, :prefecture_id, :preparation_id, :price, :postal_code, :prefecture_id, :district, :address :building_name, :phone_number

  
end