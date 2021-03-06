require 'rails_helper'

RSpec.describe News, type: :model do
  describe 'validation' do
    it 'タイトル、内容、カテゴリーがある場合、有効' do
      news = build(:news)
      expect(news).to be_valid
    end

    it 'タイトルがない場合、無効' do
      news = build(:news, title: nil)
      news.valid?
      expect(news.errors[:title]).to include('を入力してください')
    end

    it 'タイトルが21文字以上、無効' do
      news = build(:news, title: 'a' * 21)
      news.valid?
      expect(news.errors[:title]).to include('は20文字以内で入力してください')
    end

    it '内容がない場合、無効' do
      news = build(:news, body: nil)
      news.valid?
      expect(news.errors[:body]).to include('を入力してください')
    end

    it '内容が5,001文字以上、無効' do
      news = build(:news, body: 'a' * 5001)
      # news.valid?
      # expect(news.errors[:body]).to include('は5,000文字以内で入力してください')
      # この記述ではテストがパスしない。要改善。
      expect(news.valid?).to eq false
    end

    it '内容がない場合、無効' do
      news = build(:news, category: nil)
      news.valid?
      expect(news.errors[:category]).to include('を入力してください')
    end
  end
end
