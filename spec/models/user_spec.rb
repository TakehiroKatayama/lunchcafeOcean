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

    it 'メールアドレスがない場合、無効' do
      user = build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include('を入力してください')
    end

    it 'メールアドレスが256文字以上、無効' do
      user = build(:user, email: 'a' * 253 << '@a.a')
      user.valid?
      expect(user.errors[:email]).to include('は256文字以内で入力してください')
    end

    it 'メールアドレスが重複している場合、無効' do
      first_user = create(:user, email: 'test@example.com')
      second_user = build(:user, email: first_user.email)
      second_user.valid?
      expect(second_user.errors[:email]).to include('はすでに存在します')
    end

    it 'メールアドレスが指定formatに合わない場合、無効' do
      invalid_emails = %w[user@foo,com user_at_foo.org example.user@foo.foo@bar_baz.com foo@bar+baz.com foo@bar..com]
      invalid_emails.each do |invalid_email|
        expect(build(:user, email: invalid_email)).to be_invalid
      end
    end

    it '電話番号がない場合、無効' do
      user = build(:user, phonenumber: nil)
      user.valid?
      expect(user.errors[:phonenumber]).to include('を入力してください')
    end

    it '電話番号が9文字以下、無効' do
      user = build(:user, phonenumber: '0' * 9)
      user.valid?
      expect(user.errors[:phonenumber]).to include('は10文字以上で入力してください')
    end

    it '電話番号が12文字以上、無効' do
      user = build(:user, phonenumber: '0' * 12)
      user.valid?
      expect(user.errors[:phonenumber]).to include('は11文字以内で入力してください')
    end

    it '電話番号が重複している場合、無効' do
      first_user = create(:user, phonenumber: '00000000000')
      second_user = build(:user, phonenumber: first_user.phonenumber)
      second_user.valid?
      expect(second_user.errors[:phonenumber]).to include('はすでに存在します')
    end

    it '電話番号が指定formatに合わない場合、無効' do
      invalid_phonenumber = %w[００００００００００ 0000000000a]
      invalid_phonenumber.each do |invalid_phonenumber|
        expect(build(:user, phonenumber: invalid_phonenumber)).to be_invalid
      end
    end

    it '電話番号が指定formatに合わない場合、無効' do
      invalid_password = %w[Aaaa0000 0000000000 aaaaaaaa AAAAAAAA aaaa0000 AAAA0000 AAAAaaaa]
      invalid_password.each do |invalid_password|
        expect(build(:user, password: invalid_password)).to be_invalid
      end
    end

    it 'パスワード確認がない場合、無効' do
      user = build(:user, password_confirmation: nil)
      user.valid?
      expect(user.errors[:password_confirmation]).to include('を入力してください')
    end
  end
end
