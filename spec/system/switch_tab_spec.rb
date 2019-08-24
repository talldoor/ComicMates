require 'rails_helper'

describe 'タブ切り替え', type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:other_user) }
  # 3つの記事を予め作成
  let!(:article) { FactoryBot.create(:article, user: user) }
  let!(:other_article1) { FactoryBot.create(:other_article, user: other_user) }
  let!(:other_article2) { FactoryBot.create(:other_article, user: other_user) }

  before do
    sign_in_as user
  end

  describe 'ログインユーザのホーム画面' do
    context '「全ての投稿」タブをクリックしたとき' do
      it '全ての投稿記事が正しく表示されること' do
        click_link '全ての投稿'
        expect(page).to have_css('span#all-count', text: '3')
        expect(page).to have_content article.comic_title
        expect(page).to have_content other_article1.comic_title
        expect(page).to have_content other_article2.comic_title
      end
    end

    context '「自分の投稿」タブをクリックしたとき' do
      it '自分の投稿記事が正しく表示されること' do
        click_link '自分の投稿'
        expect(page).to have_css('span#mine-count', text: '1')
        expect(page).to have_content article.comic_title
        expect(page).not_to have_content other_article1.comic_title
        expect(page).not_to have_content other_article2.comic_title
      end
    end
  end
end
