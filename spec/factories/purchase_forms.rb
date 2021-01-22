FactoryBot.define do
  factory :purchase_form do
    postal_code   {'123-4567'}
    prefecture_id {3}
    district      {'横浜市緑区'}
    address       {'青山1-1'}
    building_name {'雑居ビル'}
    phone_number  {'02012345678'}
    token         {'tok_abcdefghijk00000000000000000'}
    association   :user
    association   :item
  end
end
