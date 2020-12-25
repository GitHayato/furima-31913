## usersテーブル  
| Column          | Type   | Options     |
| --------------- | ------ | ----------- |
| nickname        | string | null: false |
| email           | string | null: false |
| password        | string | null: false |
| first_name      | string | null: false |
| last_name       | string | null: false |
| first_name_kana | string | null: false |
| last_name_kana  | string | null: false |
| birthday        | text   | null: false |

### Association
- has_many :item
- has_many :purchase


## itemテーブル
| Column        | Type   | Options     |
| ------------- | ------ | ----------- |
| item_name     | string | null: false |
| explanation   | text   | null: false |
| category      | string | null: false |
| condition     | string | null: false |
| delivery_fee  | integer | null: false |
| area          | string | null: false |
| days_to_ship  | string | null: false |
| price         | integer | null: false |
| user          | reference   | foreign_key: true |

### Association
- belongs_to :users
- has_one :purchase


## purchase
| Column  | Type      | Options           |
| ------- | --------- | ----------------- |
| user    | reference | foreign_key: true |
| item    | reference | foreign_key: true |

### Association
- belongs_to :users
- belongs_to :item
- has_one :address


## address
| Column        | Type      | Options           |
| ------------- | --------- | ----------------- |
| postal_code   | string    | null: false       |
| prefectures   | string    | null: false       |
| district      | string    | null: false       |
| address       | string    | null: false       |
| building_name | string    |                   |
| phone_number  | string    | null: false       |
| purchase      | reference | foreign_key: true 

### Association
- belongs_to :purchase