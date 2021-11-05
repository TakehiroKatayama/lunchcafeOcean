require 'rails_helper'

RSpec.describe User, type: :system do
  let(:user) { create(:user) }

  describe 'ログイン前' do
    describe 'ユーザー新規登録' do
      context 'フォームの入力値が正常' do
        it 'ユーザーの新規作成が成功する' do
          visit new_user_path
          fill_in 'Name', with: 'test'
          fill_in 'Email', with: 'email@example.com'
          fill_in 'Phonenumber', with: '00000000000'
          fill_in 'Password', with: 'pass1111'
          fill_in 'パスワード(確認用)', with: 'pass1111'
          click_button '規約に同意して次へ'
          expect(current_path).to eq login_path
        end
      end
      context '登録済のメールアドレスを使用' do
        it 'ユーザーの新規作成が失敗する' do
          existed_user = create(:user)
          visit new_user_path
          fill_in 'Name', with: 'test1'
          fill_in 'Email', with: existed_user.email
          fill_in 'Phonenumber', with: '0000000000'
          fill_in 'Password', with: 'pass1111'
          fill_in 'パスワード(確認用)', with: 'pass1111'
          click_button '規約に同意して次へ'
          expect(current_path).to eq users_path
        end
      end
      context '登録済の電話番号を使用' do
        it 'ユーザーの新規作成が失敗する' do
          existed_user = create(:user)
          visit new_user_path
          fill_in 'Name', with: 'test1'
          fill_in 'Email', with: 'email@example.com'
          fill_in 'Phonenumber', with: existed_user.phonenumber
          fill_in 'Password', with: 'pass1111'
          fill_in 'パスワード(確認用)', with: 'pass1111'
          click_button '規約に同意して次へ'
          expect(current_path).to eq users_path
        end
      end
    end
  end
end
