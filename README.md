## usersテーブル  
| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| nickname           | string | null: false               |
| email              | string | null: false, unique :true |
| encrypted_password | string | null: false               |
| first_name         | string | null: false               |
| last_name          | string | null: false               |
| first_name_kana    | string | null: false               |
| last_name_kana     | string | null: false               |
| birthday           | date   | null: false               |

### Association
- has_many :items
- has_many :purchases


## itemテーブル 
| Column             | Type      | Options           |
| ------------------ | --------- | ----------------- |
| item_name          | string    | null: false       |
| explanation        | text      | null: false       |
| category_id        | integer   | null: false       |
| condition_id       | integer   | null: false       |
| delivery_fee_id    | integer   | null: false       |
| prefecture_id      | integer   | null: false       |
| preparation_id     | integer   | null: false       |
| price              | integer   | null: false       |
| user               | references | foreign_key: true |

### Association
- belongs_to :user
- has_one :purchase


## purchase
| Column  | Type      | Options           |
| ------- | --------- | ----------------- |
| user    | reference | foreign_key: true |
| item    | reference | foreign_key: true |

### Association
- belongs_to :user
- belongs_to :item
- has_one :address


## address
| Column        | Type      | Options           |
| ------------- | --------- | ----------------- |
| postal_code   | string    | null: false       |
| prefecture_id | integer   | null: false       |
| district      | string    | null: false       |
| address       | string    | null: false       |
| building_name | string    |                   |
| phone_number  | string    | null: false       |
| purchase      | reference | foreign_key: true |

### Association
- belongs_to :purchase