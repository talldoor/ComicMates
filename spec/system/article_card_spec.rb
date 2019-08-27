require 'rails_helper'

describe '未ログイン時における記事カードの機能制限', type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:other_user) }
  let!(:other_article) { FactoryBot.create(:other_article, user: other_user) }

  describe 'ログイン済みの状態' do
    before do
      sign_in_as user
      visit root_path
    end

    context '記事カードのタイトルをクリックしたとき' do
      it '記事参照画面に遷移し、「お気に入り」と「コメント」が表示されること' do
        click_link other_article.comic_title
        expect(page).to have_content other_article.comic_title
        expect(page).to have_content other_article.comic_author
        expect(page).to have_content 'お気に入り：'
        expect(page).to have_content 'コメント：'
      end
    end

    context '記事カードのユーザー画像をクリックしたとき' do
      it 'ユーザー参照画面に遷移すること' do
        find('.user-image').click
        expect(page).to have_content other_article.user.name + 'さん'
      end
    end
  end

  describe 'ログインしていない状態' do
    before do
      visit root_path
    end

    context '記事カードの記事画像をクリックしたとき' do
      it '記事参照画面に遷移し、「お気に入り」と「コメント」は表示されないこと' do
        click_link other_article.comic_title
        expect(page).to have_content other_article.comic_title
        expect(page).to have_content other_article.comic_author
        expect(page).not_to have_content 'お気に入り：'
        expect(page).not_to have_content 'コメント：'
      end
    end

    context '記事カードのユーザー画像をクリックしたとき' do
      it 'ログイン画面に遷移すること' do
        find('.user-image').click
        expect(page).to have_content 'アカウント登録もしくはログインしてください'
      end
    end
  end
end
