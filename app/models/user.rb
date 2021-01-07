class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  EMAIL_REGEX = /@.+/.freeze
  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze

  with_options presence: true do
    validates :nickname
    validates :first_name,      format: { with: /\A[ぁ-んァ-ヶ一-龥々]+\z/ }
    validates :last_name,       format: { with: /\A[ぁ-んァ-ヶ一-龥々]+\z/ }
    validates :first_name_kana, format: { with: /[\p{katakana}　ー－&&[^ -~｡-ﾟ]]+/ }
    validates :last_name_kana,  format: { with: /[\p{katakana}　ー－&&[^ -~｡-ﾟ]]+/ }
    validates :birthday
  end

  validates_format_of :email, with: EMAIL_REGEX
  validates_format_of :password, with: PASSWORD_REGEX


  has_many :items
end
