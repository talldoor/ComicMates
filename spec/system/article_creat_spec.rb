require 'rails_helper'

describe '記事投稿', type: :system do
  before do
    sign_in_as FactoryBot.create(:user)
    visit new_article_path
  end

  shared_examples_for '記事が登録されないこと' do
    it {
      expect(page).to have_content '入力に誤りがあります'
      expect(page).to have_content '新規投稿'
    }
  end

  context '全ての項目に正しく入力したとき' do
    before do
      file_path = Rails.root.join('spec', 'images', 'test_sample.png')
      attach_file 'comic_image', file_path
      fill_in '漫画タイトル（必須）', with: 'コミックタイトルA'
      fill_in '著者', with: '著者A'
      fill_in '一言でどんな作品？（必須）', with: '一言の説明A'
      fill_in '感想', with: '感想文A'
      click_on '更新する'
    end

    it '記事が正しく登録されること' do
      expect(page).to have_content '記事を投稿しました'
      expect(page).to have_content 'コミックタイトルA'
      expect(page).to have_content '著者A'
      expect(page).to have_content '一言の説明A'
      expect(page).to have_content '感想文A'
    end
  end

  context '項目に不正な値がある' do
    context '必須項目が未入力のとき' do
      before do
        fill_in '著者', with: '著者A'
        fill_in '感想', with: '感想文A'
        click_on '更新する'
      end

      it_behaves_like '記事が登録されないこと'
    end

    context '項目の上限文字数を超えて入力したとき' do
      before do
        fill_in '漫画タイトル（必須）', with: ('a' * 21)
        fill_in '一言でどんな作品？（必須）', with: '一言の説明A'
        click_on '更新する'
      end

      it_behaves_like '記事が登録されないこと'
    end
  end
end
