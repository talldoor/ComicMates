require 'rails_helper'

describe '記事編集・削除', type: :system do
  let(:user) { FactoryBot.create(:user) }
  let!(:article) { FactoryBot.create(:article, user: user) }

  before do
    sign_in_as user
    visit article_path(article)
  end

  describe '編集処理' do
    before do
      click_link '編集'
    end

    context '全ての項目に正しく入力し更新したとき' do
      before do
        file_path = Rails.root.join('spec', 'images', 'test_sample.png')
        attach_file 'comic_image', file_path
        fill_in '漫画タイトル（必須）', with: 'タイトル変更後'
        fill_in '著者', with: '著者変更後'
        fill_in '一言でどんな作品？（必須）', with: '説明変更後'
        fill_in '感想', with: '感想文変更後'
        click_on '更新する'
      end

      it '記事が正しく更新されること' do
        expect(page).to have_content '記事を更新しました'
        expect(page).to have_css('img.image-specific')
        expect(page).to have_content 'タイトル変更後'
        expect(page).to have_content '著者変更後'
        expect(page).to have_content '説明変更後'
        expect(page).to have_content '感想文変更後'
      end
    end

    context '「画像を削除」にチェックし更新したとき' do
      before do
        file_path = Rails.root.join('spec', 'images', 'test_sample.png')
        attach_file 'comic_image', file_path
        click_on '更新する'
        click_link '編集'
        check '画像を削除'
        click_on '更新する'
      end

      it 'デフォルトの画像が表示されること' do
        expect(page).to have_content '記事を更新しました'
        expect(page).to have_css('img.image-default')
      end
    end
  end

  describe '削除処理' do
    context '「削除」をクリックしたとき' do
      before do
        click_link '削除'
        page.driver.browser.switch_to.alert.accept
      end

      it '記事が削除されること' do
        expect(page).to have_content '記事を削除しました'
      end
    end
  end
end
