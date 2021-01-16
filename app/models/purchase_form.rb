class Purchase
  include ActiveModel::Model
  attr_accessor :nickname, :email, :encrypted_password, :first_name, :last_name, :first_name_kana, :last_name_kana, :birthday, :image, :item_name, :explanation, :condition_id, :category_id, :delivery_fee_id, :prefecture_id, :preparation_id, :price, :postal_code, :prefecture_id, :district, :address :building_name, :phone_number

  with_options presence: true do
    validates :image
    validates :item_name
    validates :explanation
    validates :price, format: { with: /\A[0-9]+\z/ } ,numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999, }
  end

  with_options numericality: { other_than: 1 } do
    validates :category_id
    validates :condition_id
    validates :delivery_fee_id
    validates :prefecture_id
    validates :preparation_id
  end


  EMAIL_REGEX = /@.+/.freeze
  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze

  with_options presence: true do
    validates :nickname
    validates :first_name,      format: { with: /\A[ぁ-んァ-ヶ一-龥々]+\z/ }
    validates :last_name,       format: { with: /\A[ぁ-んァ-ヶ一-龥々]+\z/ }
    validates :first_name_kana, format: { with: /[\p{katakana} ー－&&[^ -~｡-ﾟ]]+/ }
    validates :last_name_kana,  format: { with: /[\p{katakana} ー－&&[^ -~｡-ﾟ]]+/ }
    validates :birthday
  end

  validates_format_of :email, with: EMAIL_REGEX
  validates_format_of :password, with: PASSWORD_REGEX

  with_options presence: true do
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/}
    validates :district
    validates :address
    validates :phone_number, length: { is: 11 }, numericality: true
    validates :prefecture_id
  end

end