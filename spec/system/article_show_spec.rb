require 'rails_helper'

describe '記事詳細参照', type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:other_user) }
  let!(:article) { FactoryBot.create(:article, user: user) }
  let!(:other_article) { FactoryBot.create(:other_article, user: other_user) }

  shared_examples_for '「編集」「削除」が表示されること' do
    it {
      expect(page).to have_content '編集'
      expect(page).to have_content '削除'
    }
  end

  shared_examples_for '「編集」「削除」が表示されないこと' do
    it {
      expect(page).not_to have_content '編集'
      expect(page).not_to have_content '削除'
    }
  end

  describe 'ログイン後の状態' do
    before do
      sign_in_as user
    end

    context 'ログインユーザーの投稿記事を参照したとき' do
      before do
        visit article_path(article)
      end

      it '記事内容が正しく表示されること' do
        expect(page).to have_content article.comic_title
        expect(page).to have_content article.comic_author
        expect(page).to have_content article.overview
        expect(page).to have_content article.detail
      end

      it_behaves_like '「編集」「削除」が表示されること'
    end

    context 'ログインユーザー以外の記事を参照したとき' do
      before do
        visit article_path(other_article)
      end

      it '記事内容が正しく表示されること' do
        expect(page).to have_content other_article.comic_title
        expect(page).to have_content other_article.comic_author
        expect(page).to have_content other_article.overview
        expect(page).to have_content other_article.detail
      end

      it_behaves_like '「編集」「削除」が表示されないこと'
    end
  end

  describe 'ログインしていない状態' do
    context '記事を参照したとき' do
      before do
        visit article_path(article)
      end

      it '記事内容が正しく表示されること' do
        expect(page).to have_content article.comic_title
        expect(page).to have_content article.comic_author
        expect(page).to have_content article.overview
        expect(page).to have_content article.detail
      end

      it_behaves_like '「編集」「削除」が表示されないこと'
    end
  end
end
