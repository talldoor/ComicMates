require 'rails_helper'

describe 'ユーザ情報変更機能', type: :system do
  before do
    # テストユーザをログインさせる
    @user = FactoryBot.create(:user)
    visit new_user_session_path
    fill_in 'メールアドレス', with: @user.email
    fill_in 'パスワード', with: @user.password
    click_button 'ログイン'
    visit edit_user_registration_path
  end

  describe 'プロフィール情報変更' do
    context '正しい情報を入力した場合' do
      it '画像とマイベストと自己紹介を登録' do
        file_path = Rails.root.join('spec', 'images', 'test_sample.png')
        attach_file 'プロフィール画像', file_path
        fill_in 'マイベストコミック１', with: 'データ１'
        fill_in 'マイベストコミック２', with: 'データ２'
        fill_in 'マイベストコミック３', with: 'データ３'
        fill_in '自己紹介', with: 'じこしょうかいぶん'
        click_button '更新する'
        expect(page).to have_content 'アカウント情報を変更しました'
      end
    end
  end

  describe 'アカウント情報変更' do
    before do
      visit setting_account_path
    end

    context '正しい情報を入力した場合' do
      it 'ユーザーネームとメールアドレスを登録' do
        fill_in 'ユーザーネーム', with: 'テストユーザー変更後'
        fill_in 'メールアドレス', with: 'test111@example.com'
        click_button '更新する'
        expect(page).to have_content 'アカウント情報を変更しました'
        expect(page).to have_content 'テストユーザー変更後'
        expect(page).to have_content 'test111@example.com'
      end
    end

    context '不正な情報を入力した場合' do
      it 'ユーザーネームとメールアドレスが空で登録できない' do
        fill_in 'ユーザーネーム', with: ''
        fill_in 'メールアドレス', with: ''
        click_button '更新する'
        expect(page).to have_content '入力に誤りがあります'
      end

      it 'ユーザーネームが空で登録できない' do
        fill_in 'ユーザーネーム', with: ''
        fill_in 'メールアドレス', with: 'test111@example.com'
        click_button '更新する'
        expect(page).to have_content '入力に誤りがあります'
      end

      it 'メールアドレスが空で登録できない' do
        fill_in 'ユーザーネーム', with: 'テストユーザー変更後'
        fill_in 'メールアドレス', with: ''
        click_button '更新する'
        expect(page).to have_content '入力に誤りがあります'
      end
    end
  end

  describe 'パスワード情報変更' do
    before do
      visit setting_password_path
    end

    context '正しい情報を入力した場合' do
      it 'パスワードを登録' do
        fill_in '現在のパスワード', with: @user.password
        fill_in 'パスワード', with: 'newpassword'
        fill_in '確認用パスワード', with: 'newpassword'
        click_button '更新する'
        expect(page).to have_content 'パスワードを変更しました'
      end
    end

    context '不正な情報を入力した場合' do
      it '現在のパスワードが異なり登録できない' do
        fill_in '現在のパスワード', with: 'wrongpass'
        fill_in 'パスワード', with: 'newpassword'
        fill_in '確認用パスワード', with: 'newpassword'
        click_button '更新する'
        expect(page).to have_content '入力に誤りがあります'
      end

      it 'パスワードが空で登録できない' do
        fill_in '現在のパスワード', with: ''
        fill_in 'パスワード', with: ''
        fill_in '確認用パスワード', with: ''
        click_button '更新する'
        expect(page).to have_content '入力に誤りがあります'
      end

      it '確認用パスワードが異なり登録できない' do
        fill_in '現在のパスワード', with: @user.password
        fill_in 'パスワード', with: 'newpassword'
        fill_in '確認用パスワード', with: 'newpassword2'
        click_button '更新する'
        expect(page).to have_content '入力に誤りがあります'
      end
    end
  end
end
