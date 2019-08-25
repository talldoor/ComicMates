require 'rails_helper'

describe 'ログイン機能', type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:test_user) { FactoryBot.create(:test_user) }

  before do
    visit new_user_session_path
  end

  context '有効な情報を入力したとき' do
    it 'ログインできること' do
      fill_in 'メールアドレス', with: user.email
      fill_in 'パスワード', with: user.password
      click_button 'ログイン'
      expect(page).to have_content 'ログインしました'
    end
  end

  context '不正な組み合わせを入力したとき' do
    it 'ログインできないこと' do
      fill_in 'メールアドレス', with: user.email
      fill_in 'パスワード', with: 'incorrect'
      click_button 'ログイン'
      expect(page).to have_content 'メールアドレスまたはパスワードが違います'
    end
  end

  context '未入力のとき' do
    it 'ログインできないこと' do
      click_button 'ログイン'
      expect(page).to have_content 'メールアドレスまたはパスワードが違います'
    end
  end

  context '「テストユーザーでログイン」をクリックしたとき' do
    it 'ログインできること' do
      click_button 'テストユーザーでログイン'
      expect(page).to have_content 'ログインしました'
    end
  end
end
