require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validation' do
    it 'ユーザー名、メールアドレス、電話番号、パスワードがある場合、有効' do
      user = build(:user)
      expect(user).to be_valid
    end

    it 'ユーザー名がない場合、無効' do
      user = build(:user, name: nil)
      user.valid?
      expect(user.errors[:name]).to include('を入力してください')
    end

    it 'ユーザー名が21文字以上、無効' do
      user = build(:user, name: 'a' * 21)
      user.valid?
      expect(user.errors[:name]).to include('は20文字以内で入力してください')
    end
  end
end
