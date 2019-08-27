require 'rails_helper'

describe 'お気に入り機能', type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:other_user) }
  let!(:other_article) { FactoryBot.create(:other_article, user: other_user) }
  let(:like) do
    FactoryBot.create(:like, user: user, article: other_article)
  end

  describe '記事詳細参照画面' do
    context '無効状態のハートマークをクリックしたとき' do
      before do
        sign_in_as user
        visit article_path(other_article)
        find('#like-btn').click
        wait_for_ajax
      end

      it 'ハートマークが有効状態になること' do
        expect(page).to have_css('.fa-heart#unlike-btn')
        expect(page).to have_css('span#article-like-count', text: '1')
      end
    end

    context '有効状態のハートマークをクリックしたとき' do
      before do
        like
        sign_in_as user
        visit article_path(other_article)
        find('#unlike-btn').click
        wait_for_ajax
      end

      it 'ハートマークが無効状態になること' do
        expect(page).to have_css('.fa-heart#like-btn')
        expect(page).to have_css('span#article-like-count', text: '0')
      end
    end
  end

  describe 'ホーム画面の「全ての投稿」タブ ' do
    context '無効状態のハートマークをクリックしたとき' do
      before do
        sign_in_as user
        visit root_path
        find("#like-form-#{other_article.id}").click
        wait_for_ajax
      end

      it 'ハートマークが有効状態になること' do
        expect(page).to have_css('.fa-heart#unlike-btn')
        expect(page).to have_css('span#article-like-count', text: '1')
      end
    end

    context '有効状態のハートマークをクリックしたとき' do
      before do
        like
        sign_in_as user
        visit root_path
        find("#like-form-#{other_article.id}").click
        wait_for_ajax
      end

      it 'ハートマークが無効状態になること' do
        expect(page).to have_css('.fa-heart#like-btn')
        expect(page).to have_css('span#article-like-count', text: '0')
      end
    end
  end
end
