require 'rails_helper'

describe 'タブ切り替え', type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:other_user1) { FactoryBot.create(:other_user) }
  let!(:other_user2) { FactoryBot.create(:other_user) }
  let!(:article) { FactoryBot.create(:article, user: user) }
  let!(:other_article1) { FactoryBot.create(:other_article, user: other_user1) }
  let!(:other_article2) { FactoryBot.create(:other_article, user: other_user1) }
  # フォロー関係を作成（userはフォロワーが1、フォローが2。other_user1はフォロワーが2、フォローが1）
  let!(:relationships) do
    FactoryBot.create(:relationship, follower: user, followed: other_user1)
    FactoryBot.create(:relationship, follower: user, followed: other_user2)
    FactoryBot.create(:relationship, follower: other_user1, followed: user)
    FactoryBot.create(:relationship, follower: other_user2, followed: other_user1)
  end
  # お気入り関係を作成
  let!(:likes) do
    FactoryBot.create(:like, user: user, article: other_article1)
    FactoryBot.create(:like, user: other_user1, article: other_article2)
  end

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

    context '「お気に入り」タブをクリックしたとき' do
      it 'お気に入りの記事が正しく表示されること' do
        click_link 'お気に入り'
        expect(page).to have_css('span#like-count', text: '1')
        expect(page).to have_content other_article1.comic_title
        expect(page).not_to have_content other_article2.comic_title
      end
    end

    context '「フォロワー」タブをクリックしたとき' do
      it 'フォロワーが正しく表示されること' do
        click_link 'フォロワー'
        expect(page).to have_css('span#followers-count', text: '1')
        expect(page).to have_content other_user1.name
        expect(page).not_to have_content other_user2.name
      end
    end

    context '「フォロー」タブをクリックしたとき' do
      it 'フォローが正しく表示されること' do
        click_link 'フォロー'
        expect(page).to have_css('span#following-count', text: '2')
        expect(page).to have_content other_user1.name
        expect(page).to have_content other_user2.name
      end
    end
  end

  describe 'ユーザー参照画面' do
    before do
      visit user_path(other_user1)
    end

    context '「投稿記事」タブをクリックしたとき' do
      it 'ユーザーの投稿記事が正しく表示されること' do
        click_link '投稿記事'
        expect(page).to have_css('span#mine-count', text: '2')
        expect(page).to have_content other_article1.comic_title
        expect(page).to have_content other_article2.comic_title
      end
    end

    context '「お気に入り」タブをクリックしたとき' do
      it 'お気に入りの記事が正しく表示されること' do
        click_link 'お気に入り'
        expect(page).to have_css('span#like-count', text: '1')
        expect(page).to have_content other_article2.comic_title
        expect(page).not_to have_content article.comic_title
      end
    end

    context '「フォロワー」タブをクリックしたとき' do
      it 'フォロワーが正しく表示されること' do
        click_link 'フォロワー'
        expect(page).to have_css('span#followers-count', text: '2')
        expect(page).to have_content user.name
        expect(page).to have_content other_user2.name
      end
    end

    context '「フォロー」タブをクリックしたとき' do
      it 'フォローが正しく表示されること' do
        click_link 'フォロー'
        expect(page).to have_css('span#following-count', text: '1')
        expect(page).to have_content user.name
        expect(page).not_to have_content other_user2.name
      end
    end
  end
end
