FactoryBot.define do
  factory :user do
    nickname              {Faker::Name.initials(number: 2)}
    email                 {Faker::Internet.free_email}
    password              {'test1234TEST'}
    password_confirmation {password}
    first_name            {"瑠美衣"}
    last_name             {"零瑠豆"}
    first_name_kana       {"カタカナ"}
    last_name_kana        {"カタカナ"}
    birthday              {Faker::Date.birthday}
  end
end