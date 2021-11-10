require 'rails_helper'

RSpec.describe News, type: :model do
  describe 'validation' do
    it 'タイトル、内容、カテゴリーがある場合、有効' do
      news = build(:news)
      expect(news).to be_valid
    end
  end
end
