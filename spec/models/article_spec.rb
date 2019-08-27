require 'rails_helper'

RSpec.describe Article, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:article) { FactoryBot.create(:article, user: user) }

  describe '有効' do
    context '全ての項目に正しい値が存在するとき' do
      it '記事が有効となること' do
        expect(article).to be_valid
      end
    end

    context 'リレーションが正しく行わているとき' do
      it 'ユーザー名が一致すること' do
        expect(article.user.name).to eq user.name
      end
    end
  end

  describe '無効' do
    context 'タイトルが存在しないとき' do
      it '記事が無効となること' do
        article.comic_title = nil
        expect(article).not_to be_valid
      end
    end

    context 'タイトルが文字数オーバーのとき' do
      it '記事が無効となること' do
        article.comic_title = 'X' * 21
        expect(article).not_to be_valid
      end
    end

    context '著者名が文字数オーバーのとき' do
      it '記事が無効となること' do
        article.comic_author = 'X' * 21
        expect(article).not_to be_valid
      end
    end

    context '概要が存在しないとき' do
      it '記事が無効となること' do
        article.overview = nil
        expect(article).not_to be_valid
      end
    end

    context '概要が文字数オーバーのとき' do
      it '記事が無効となること' do
        article.overview = 'X' * 101
        expect(article).not_to be_valid
      end
    end

    context '詳細が文字数オーバーのとき' do
      it '記事が無効となること' do
        article.detail = 'X' * 401
        expect(article).not_to be_valid
      end
    end
  end
end
