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

    it '指定formatに合わないemailを許容しないこと' do
      invalid_emails = %w[user@foo,com user_at_foo.org example.user@foo.foo@bar_baz.com foo@bar+baz.com foo@bar..com]
      invalid_emails.each do |_invalid_email|
        expect(user.errors[:email]).to be_invalid
      end
    end
  end
end
