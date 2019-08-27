require 'rails_helper'

describe '記事検索', type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:other_user) }
  let!(:other_article) { FactoryBot.create(:other_article, user: other_user) }

  before do
    sign_in_as user
    click_link '記事を探す'
  end

  describe '検索成功' do
    context '存在するタイトルで検索したとき' do
      it 'ヒットした記事が表示されること' do
        fill_in 'タイトル、または著者名を入力', with: other_article.comic_title
        click_on '検索'
        expect(page).to have_content other_article.comic_title
      end
    end

    context '存在する著者名で検索したとき' do
      it 'ヒットした記事が表示されること' do
        fill_in 'タイトル、または著者名を入力', with: other_article.comic_author
        click_on '検索'
        expect(page).to have_content other_article.comic_title
      end
    end
  end

  describe '検索失敗' do
    context '存在しないタイトルで検索したとき' do
      it '記事が表示されないこと' do
        fill_in 'タイトル、または著者名を入力', with: '存在しないタイトル'
        click_on '検索'
        expect(page).to have_content '該当する記事が見つかりませんでした'
        expect(page).not_to have_content other_article.comic_title
      end
    end
  end
end
