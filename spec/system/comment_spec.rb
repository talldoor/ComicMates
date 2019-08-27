require 'rails_helper'

describe 'コメント機能', type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:other_user1) { FactoryBot.create(:other_user) }
  let!(:other_user2) { FactoryBot.create(:other_user) }
  # other_user2が作成した記事
  let!(:other_article2) { FactoryBot.create(:other_article, user: other_user2) }
  # userがother_article2にコメント
  let(:comment) { FactoryBot.create(:comment, user: user, article: other_article2) }
  # other_user1がother_article2にコメント
  let(:other_comment1) { FactoryBot.create(:comment, user: other_user1, article: other_article2) }

  before do
    sign_in_as user
  end

  shared_examples_for 'コメントが登録されないこと' do
    it {
      expect(page).to have_content 'コメント入力に誤りがあります'
      expect(page).to have_css('span#article-comment-count', text: '0')
    }
  end

  describe '記事詳細参照画面' do
    context 'コメントを正しく登録したとき' do
      before do
        visit article_path(other_article2)
        fill_in 'コメントを書く（50文字以内）', with: 'テストコメント'
        click_on '送信'
      end

      it 'コメントが表示され、コメント数が1つ増えること' do
        expect(page).to have_content 'コメントしました'
        expect(page).to have_css("#comment-user-#{user.id}")
        expect(page).to have_content 'テストコメント'
        expect(page).to have_css('#comment-delete')
        expect(page).to have_css('span#article-comment-count', text: '1')
      end
    end

    context 'コメントを文字数オーバーで登録したとき' do
      before do
        visit article_path(other_article2)
        fill_in 'コメントを書く（50文字以内）', with: ('a' * 51)
        click_on '送信'
      end

      it_behaves_like 'コメントが登録されないこと'
    end

    context 'コメント未入力で登録したとき' do
      before do
        visit article_path(other_article2)
        click_on '送信'
      end

      it_behaves_like 'コメントが登録されないこと'
    end

    context 'コメントを削除したとき' do
      before do
        comment
        visit article_path(other_article2)
        find("#comment-delete").click
        page.driver.browser.switch_to.alert.accept
      end

      it 'コメントが削除され、コメント数が1つ減ること' do
        expect(page).to have_content 'コメントを削除しました'
        expect(page).to have_css('span#article-comment-count', text: '0')
      end
    end

    context 'その他のユーザーがコメントをしていたとき' do
      before do
        other_comment1
        visit article_path(other_article2)
      end

      it 'その他のユーザーのコメントが表示されること' do
        expect(page).to have_css("#comment-user-#{other_user1.id}")
        expect(page).to have_content other_comment1.content
        expect(page).not_to have_css('#comment-delete')
        expect(page).to have_css('span#article-comment-count', text: '1')
      end
    end
  end

  describe 'ホーム画面（記事カードのコメント数の確認）' do
    context 'コメントが既に登録されているとき' do
      before do
        comment
        other_comment1
        visit root_path
      end

      it '記事カードのコメント数が正しく表示されること' do
        expect(page).to have_content other_article2.comic_title
        expect(page).to have_css('span#article-comment-count', text: '2')
      end
    end

    context 'コメントが全く登録されていないとき' do
      before do
        visit root_path
      end

      it '記事カードのコメント数が0と表示されること' do
        expect(page).to have_content other_article2.comic_title
        expect(page).to have_css('span#article-comment-count', text: '0')
      end
    end

    context 'コメントが既に登録されている状態から削除されたとき' do
      before do
        comment
        other_comment1
        visit article_path(other_article2)
        find("#comment-delete").click
        page.driver.browser.switch_to.alert.accept
        visit root_path
      end

      it '記事カードのコメント数が1つ減ること' do
        expect(page).to have_content other_article2.comic_title
        expect(page).to have_css('span#article-comment-count', text: '1')
      end
    end
  end
end
