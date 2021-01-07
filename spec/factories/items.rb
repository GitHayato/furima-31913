FactoryBot.define do
  factory :item do
    item_name         {'name'}
    explanation       {'explanation'}
    category_id       {'2'}
    condition_id      {'2'}
    delivery_fee_id   {'2'}
    prefecture_id     {'2'}
    preparation_id    {'2'}
    price             {Faker::Number.within(range: 300..9999999)}
    association       :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end

  end
end
