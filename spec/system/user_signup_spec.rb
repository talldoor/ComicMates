require 'rails_helper'

describe '新規登録機能', type: :system do
  let!(:test_user) { FactoryBot.create(:test_user) }

  before do
    visit new_user_registration_path
  end

  context '有効な情報を入力したとき' do
    it 'アカウント登録できること' do
      fill_in 'ユーザー名', with: 'Test000'
      fill_in 'メールアドレス', with: 'text000@example.com'
      fill_in 'パスワード（６文字以上）', with: 'password'
      fill_in 'パスワード（確認用）', with: 'password'
      click_button '新規登録'
      expect(page).to have_content 'アカウント登録が完了しました'
    end
  end

  context '無効な情報を入力したとき' do
    it 'アカウント登録できないこと' do
      fill_in 'ユーザー名', with: ''
      fill_in 'メールアドレス', with: ''
      fill_in 'パスワード（６文字以上）', with: ''
      fill_in 'パスワード（確認用）', with: ''
      click_button '新規登録'
      expect(page).to have_content '保存されませんでした'
    end
  end

  context 'テストユーザーでログイン」クリックしたとき' do
    it 'ログインできること' do
      click_button 'テストユーザーでログイン'
      expect(page).to have_content 'ログインしました'
    end
  end
end
