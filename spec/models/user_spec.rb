require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー情報' do
    context '新規登録できるとき' do
      it 'ニックネームが必須であること' do
        @user.nickname = "aaaaaa"
        expect(@user).to be_valid
      end
      it 'メールアドレスが必須であること' do
        @user.email = "abc@example.com"
        expect(@user).to be_valid
      end
      it 'メールアドレスが一意性であること' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email != @user.email 
        expect(@user).to be_valid
      end
      it 'メールアドレスに@が含まれていること' do
        @user.email = 'test@example.com'
        expect(@user).to be_valid
      end
      it 'パスワードが必須であること' do
        @user.password = "example0"
        @user.password_confirmation = "example0"
        expect(@user).to be_valid
      end
      it 'パスワードは、半角英数字混合での入力が必須であること' do
        @user.password = 'abc123ABC'
        @user.password_confirmation = @user.password
        expect(@user).to be_valid
      end
      it 'パスワードとパスワード(確認用)、値の一致が必須であること' do
        @user.password = @user.password_confirmation
        expect(@user).to be_valid
      end
    end
    context '新規登録できないとき' do
      it 'ニックネームが空であること' do
        @user.nickname = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank") 
      end
      it 'メールアドレスが空であること' do
        @user.email = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'パスワードが空であるとき' do
        @user.password = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'パスワードはあるが、確認用が空であること' do
        @user.password_confirmation = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it '重複したメールアドレスであること' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Email is invalid")
      end
      it 'メールアドレスに＠が含まれないこと' do
        @user.email = 'abcexample.com'
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end
      it 'パスワードが5文字以下であること' do
        @user.password = 'asd12'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
        
      end
      it 'パスワードが半角英数字混合でないこと' do
        @user.password = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid")
      end
    end
  end
  describe '本人情報確認' do
    context '本人確認ができるとき' do
      it 'ユーザー本名は、名字と名前がそれぞれ必須であること' do
        @user.last_name = "瑠美衣"
        @user.first_name = "零瑠豆"
        expect(@user).to be_valid
      end
      it 'ユーザー本名は、全角(漢字・ひらがな・カタカナ)での入力が必須であること' do
        @user.last_name = "瑠びイ"
        @user.first_name = "零るズ"
        expect(@user).to be_valid
      end
      it 'ユーザー本名のフリガナは、名字と名前でそれぞれ必須であること' do
        @user.last_name_kana = "ルビイ"
        @user.first_name_kana = "レイルズ"
        expect(@user).to be_valid
      end
      it 'ユーザー本名のフリガナは、全角(カタカナ)での入力が必須であること' do
        @user.last_name_kana = "ルビイ"
        @user.first_name_kana = "レイルズ"
        expect(@user).to be_valid
      end
      it '生年月日が必須であること' do
        @user.birthday = "Wed, 03 Jul 1968"
        expect(@user).to be_valid
      end
    end
    context '本人確認ができないとき' do
      it 'ユーザー本名の名字が空であること' do
        @user.last_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end
      it 'ユーザー本名の名前が空であること' do
        @user.first_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      it 'ユーザー本名の名字が全角(漢字・ひらがな・カタカナ)以外で入力していること' do
        @user.last_name = "ruby"
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name is invalid")
      end
      it 'ユーザー本名の名前が全角(漢字・ひらがな・カタカナ)以外で入力していること' do
        @user.first_name = "rails"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name is invalid")
      end
      it 'ユーザー本名のフリガナの名字が空であること' do
        @user.last_name_kana = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank")
      end
      it 'ユーザー本名のフリガナの名前が空であること' do
        @user.first_name_kana = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end
      it 'ユーザ本名のフリガナの名字が、全角(カタカナ)以外で入力していること' do
        @user.last_name_kana = "ruby"
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana is invalid")
      end
      it 'ユーザ本名のフリガナの名前が、全角(カタカナ)以外で入力していること' do
        @user.first_name_kana = "rails"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana is invalid")
      end
      it '生年月日が入力されていないこと' do
        @user.birthday = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end
  end
end
