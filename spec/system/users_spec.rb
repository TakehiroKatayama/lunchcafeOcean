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
          expect(page).to have_content '会員登録が完了しました。'
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
          expect(page).to have_content '会員登録に失敗しました。'
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

  describe 'マイページ' do
    context 'ログインしていない状態' do
      it 'マイページへのアクセスが失敗する' do
        visit '/mypage'
        expect(current_path).to eq root_path
      end
    end
  end

  describe 'ログイン後' do
    before { login(user) }

    describe 'ユーザー編集' do
      context 'フォームの入力値が正常' do
        it 'ユーザーの編集が成功する' do
          visit '/mypage/edit'
          fill_in 'Name', with: 'user_1'
          fill_in 'Email', with: 'update@example.com'
          fill_in 'Phonenumber', with: '09000000000'
          click_button '更新'
          expect(page).to have_content '登録情報を更新しました。'
          expect(current_path).to eq '/mypage'
        end
      end
    end

    context '名前が未入力' do
      it 'ユーザーの編集が失敗する' do
        visit '/mypage/edit'
        fill_in 'Name', with: ''
        fill_in 'Email', with: 'update@example.com'
        fill_in 'Phonenumber', with: '09000000000'
        click_button '更新'
        expect(current_path).to eq '/mypage/edit'
      end
    end

    context 'メールアドレスが未入力' do
      it 'ユーザーの編集が失敗する' do
        visit '/mypage/edit'
        fill_in 'Name', with: 'user_1'
        fill_in 'Email', with: ''
        fill_in 'Phonenumber', with: '09000000000'
        click_button '更新'
        expect(current_path).to eq '/mypage/edit'
      end
    end

    context '電話番号が未入力' do
      it 'ユーザーの編集が失敗する' do
        visit '/mypage/edit'
        fill_in 'Name', with: 'user_1'
        fill_in 'Email', with: 'update@example.com'
        fill_in 'Phonenumber', with: ''
        click_button '更新'
        expect(current_path).to eq '/mypage/edit'
      end
    end

    context '名前が21文字以上' do
      it 'ユーザーの編集が失敗する' do
        visit '/mypage/edit'
        fill_in 'Name', with: 'a' * 21
        fill_in 'Email', with: 'update@example.com'
        fill_in 'Phonenumber', with: '09000000000'
        click_button '更新'
        expect(current_path).to eq '/mypage/edit'
      end
    end

    context 'メールアドレスが256文字以上' do
      it 'ユーザーの編集が失敗する' do
        visit '/mypage/edit'
        fill_in 'Name', with: 'user_1'
        fill_in 'Email', with: 'a' * 253 << '@a.a'
        fill_in 'Phonenumber', with: '09000000000'
        click_button '更新'
        expect(current_path).to eq '/mypage/edit'
      end
    end

    context '電話番号が9文字以下' do
      it 'ユーザーの編集が失敗する' do
        visit '/mypage/edit'
        fill_in 'Name', with: 'user_1'
        fill_in 'Email', with: 'update@example.com'
        fill_in 'Phonenumber', with: '090000000'
        click_button '更新'
        expect(current_path).to eq '/mypage/edit'
      end
    end

    context '電話番号が12文字以上' do
      it 'ユーザーの編集が失敗する' do
        visit '/mypage/edit'
        fill_in 'Name', with: 'user_1'
        fill_in 'Email', with: 'update@example.com'
        fill_in 'Phonenumber', with: '090000000000'
        click_button '更新'
        expect(current_path).to eq '/mypage/edit'
      end
    end

    context '登録済のメールアドレスを使用' do
      it 'ユーザーの編集が失敗する' do
        visit '/mypage/edit'
        other_user = create(:user)
        fill_in 'Name', with: 'user_1'
        fill_in 'Email', with: other_user.email
        fill_in 'Phonenumber', with: '090000000000'
        click_button '更新'
        expect(current_path).to eq '/mypage/edit'
      end
    end

    context '登録済の電話番号を使用' do
      it 'ユーザーの編集が失敗する' do
        visit '/mypage/edit'
        other_user = create(:user)
        fill_in 'Name', with: 'user_1'
        fill_in 'Email', with: 'update@example.com'
        fill_in 'Phonenumber', with: other_user.phonenumber
        click_button '更新'
        expect(current_path).to eq '/mypage/edit'
      end
    end

    context 'ログアウトボタンをクリック' do
      it 'ログアウト処理が成功する' do
        visit '/mypage'
        click_link 'ログアウト'
        expect(page).to have_content 'ログアウトしました。'
        expect(current_path).to eq root_path
      end
    end
  end
end
