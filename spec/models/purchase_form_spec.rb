require 'rails_helper'

RSpec.describe PurchaseForm, type: :model do
  describe '商品購入' do
    before do
      @purchase_form = FactoryBot.build(:purchase_form)
    end

    it '商品購入ができること' do
      expect(@purchase_form).to be_valid
    end

    it '郵便番号が空だと購入できない' do
      @purchase_form.postal_code = ''
      @purchase_form.valid?
      expect(@purchase_form.errors.full_messages).to include("Postal code can't be blank")
    end

    it '郵便番号にハイフンがないと購入できない' do
      @purchase_form.postal_code = '1234567'
      @purchase_form.valid?
      expect(@purchase_form.errors.full_messages).to include("Postal code is invalid")
    end

    it '都道府県の選択をしていないと購入できない' do
      @purchase_form.prefecture_id = 1
      @purchase_form.valid?
      expect(@purchase_form.errors.full_messages).to include("Prefecture must be other than 1")
    end

    it '地域が空だと購入できない' do
      @purchase_form.district = ''
      @purchase_form.valid?
      expect(@purchase_form.errors.full_messages).to include("District can't be blank")
    end

    it '番地が空だと購入できない' do
      @purchase_form.address = ''
      @purchase_form.valid?
      expect(@purchase_form.errors.full_messages).to include("Address can't be blank")
    end

    it '建物名は空でも購入できること' do
      @purchase_form.building_name = ''
      expect(@purchase_form).to be_valid
    end

    it '電話番号が空だと購入できない' do
      @purchase_form.phone_number = ''
      @purchase_form.valid?
      expect(@purchase_form.errors.full_messages).to include("Phone number can't be blank")
    end

    it '電話番号にハイフンがあれば購入できない' do
      @purchase_form.phone_number = '020-1234-5678'
      @purchase_form.valid?
      expect(@purchase_form.errors.full_messages).to include("Phone number is the wrong length (should be 11 characters)")
    end

    it '電話番号は11桁でないと購入できない' do
      @purchase_form.phone_number = '020123456'
      @purchase_form.valid?
      expect(@purchase_form.errors.full_messages).to include("Phone number is the wrong length (should be 11 characters)")
    end

    it 'tokenがなければ購入できない' do
      @purchase_form.token = ''
      @purchase_form.valid?
      expect(@purchase_form.errors.full_messages).to include("Token can't be blank")
    end
  end
end
