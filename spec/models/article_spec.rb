require 'rails_helper'

RSpec.describe Article, type: :model do
  describe 'バリデーションの確認' do
    before do
      @article = FactoryBot.create(:article)
    end

    context '記事が有効' do
      it 'リレーションが正しく行わている' do
        expect(@article.user.name).to eq 'テストユーザー'
      end

      it '全ての項目に正しい値が存在する' do
        expect(@article).to be_valid
      end
    end

    context '記事が無効' do
      it 'タイトルが存在しない' do
        @article.comic_title = nil
        expect(@article).not_to be_valid
      end

      it 'タイトルの文字数オーバー' do
        @article.comic_title = 'X' * 21
        expect(@article).not_to be_valid
      end

      it '著者名の文字数オーバー' do
        @article.comic_author = 'X' * 21
        expect(@article).not_to be_valid
      end

      it '概要が存在しない' do
        @article.overview = nil
        expect(@article).not_to be_valid
      end

      it '概要の文字数オーバー' do
        @article.overview = 'X' * 101
        expect(@article).not_to be_valid
      end

      it '詳細の文字数オーバー' do
        @article.detail = 'X' * 401
        expect(@article).not_to be_valid
      end
    end
  end
end
