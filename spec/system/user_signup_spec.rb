require 'rails_helper'

describe '新規登録機能', type: :system do
  before do
    visit new_user_registration_path
  end

  context '有効な情報を入力した場合' do
    it '全ての項目に入力し登録' do
      fill_in 'ユーザー名', with: 'Test000'
      fill_in 'メールアドレス', with: 'text000@example.com'
      fill_in 'パスワード（６文字以上）', with: 'password'
      fill_in 'パスワード（確認用）', with: 'password'
      click_button '新規登録'
      expect(page).to have_content 'アカウント登録が完了しました'
    end
  end

  context '無効な情報を入力した場合' do
    it '空の情報を入力し登録されない' do
      fill_in 'ユーザー名', with: ''
      fill_in 'メールアドレス', with: ''
      fill_in 'パスワード（６文字以上）', with: ''
      fill_in 'パスワード（確認用）', with: ''
      click_button '新規登録'
      expect(page).to have_content '保存されませんでした'
    end
  end

  context '簡易ログイン機能を使用した場合' do
    it '「テストユーザーでログイン」ボタン押下' do
      FactoryBot.create(:test_user)
      click_button 'テストユーザーでログイン'
      expect(page).to have_content 'ログインしました'
    end
  end
end
