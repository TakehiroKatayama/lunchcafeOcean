require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validation' do
    it 'ユーザー名、メールアドレス、電話番号、パスワードがある場合、有効' do
      user = build(:user)
      expect(user).to be_valid
    end
  end
end
