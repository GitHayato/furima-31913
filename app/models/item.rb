class Item < ApplicationRecord
  has_one_attached :image
  belongs_to :user

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :delivery_fee
  belongs_to :prefecture
  belongs_to :preparation

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
end
