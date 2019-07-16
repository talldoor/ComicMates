require 'rails_helper'

describe 'ログイン機能', type: :system do
  before do
    @user = FactoryBot.create(:user)
    visit new_user_session_path
  end

  context '有効な情報を入力した場合' do
    it '正しい組み合わせを入力しログイン' do
      fill_in 'メールアドレス', with: @user.email
      fill_in 'パスワード', with: @user.password
      click_button 'ログイン'
      expect(page).to have_content 'ログインしました'
    end
  end

  context '無効な情報を入力した場合' do
    it '正しくない組み合わせを入力しログインしない' do
      fill_in 'メールアドレス', with: @user.email
      fill_in 'パスワード', with: 'incorrect'
      click_button 'ログイン'
      expect(page).to have_content 'メールアドレスまたはパスワードが違います'
    end
  end
end
