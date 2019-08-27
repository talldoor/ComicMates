require 'rails_helper'

describe 'ユーザ情報変更機能', type: :system do
  let(:user) { FactoryBot.create(:user) }

  before do
    sign_in_as user
    visit edit_user_registration_path
  end

  describe 'プロフィール情報変更' do
    context '正しい情報を入力したとき' do
      it '画像とマイベストと自己紹介が登録できること' do
        file_path = Rails.root.join('spec', 'images', 'test_sample.png')
        attach_file 'profile_image', file_path
        fill_in 'my_best1', with: 'データ１'
        fill_in 'my_best2', with: 'データ２'
        fill_in 'my_best3', with: 'データ３'
        fill_in '自己紹介', with: 'じこしょうかいぶん'
        click_button '更新する'
        expect(page).to have_content 'アカウント情報を変更しました'
      end
    end

    context '「画像を削除」にチェックを入れて更新したとき' do
      it '画像を削除できること' do
        file_path = Rails.root.join('spec', 'images', 'test_sample.png')
        attach_file 'profile_image', file_path
        click_button '更新する'
        check '画像を削除'
        click_button '更新する'
        expect(page).to have_content 'アカウント情報を変更しました'
        expect(page).to have_css('img.profile-image-default')
      end
    end
  end

  describe 'アカウント情報変更' do
    before do
      visit setting_account_path
    end

    context '正しい情報を入力したとき' do
      it 'ユーザーネームとメールアドレスが登録できること' do
        fill_in 'ユーザーネーム', with: 'ユーザー変更後'
        fill_in 'メールアドレス', with: 'test111@example.com'
        click_button '更新する'
        expect(page).to have_content 'アカウント情報を変更しました'
      end
    end

    describe '不正な情報' do
      context 'ユーザーネームがないとき' do
        it '更新できないこと' do
          fill_in 'ユーザーネーム', with: ''
          fill_in 'メールアドレス', with: 'test111@example.com'
          click_button '更新する'
          expect(page).to have_content '入力に誤りがあります'
        end
      end

      context 'メールアドレスがないとき' do
        it '更新できないこと' do
          fill_in 'ユーザーネーム', with: 'ユーザー変更後'
          fill_in 'メールアドレス', with: ''
          click_button '更新する'
          expect(page).to have_content '入力に誤りがあります'
        end
      end
    end
  end

  describe 'パスワード情報変更' do
    before do
      visit setting_password_path
    end

    context '正しい情報を入力したとき' do
      it 'パスワードを更新できること' do
        fill_in '現在のパスワード', with: user.password
        fill_in 'パスワード', with: 'newpassword'
        fill_in '確認用パスワード', with: 'newpassword'
        click_button '更新する'
        expect(page).to have_content 'パスワードを変更しました'
      end
    end

    describe '不正な情報' do
      context '現在のパスワードが異なるとき' do
        it 'パスワードが更新できないこと' do
          fill_in '現在のパスワード', with: 'wrongpass'
          fill_in 'パスワード', with: 'newpassword'
          fill_in '確認用パスワード', with: 'newpassword'
          click_button '更新する'
          expect(page).to have_content '入力に誤りがあります'
        end
      end

      context 'パスワードが無いとき' do
        it 'パスワードが更新できないこと' do
          fill_in '現在のパスワード', with: ''
          fill_in 'パスワード', with: ''
          fill_in '確認用パスワード', with: ''
          click_button '更新する'
          expect(page).to have_content '入力に誤りがあります'
        end
      end

      context '確認用パスワードが異なるとき' do
        it 'パスワードが更新できないこと' do
          fill_in '現在のパスワード', with: user.password
          fill_in 'パスワード', with: 'newpassword'
          fill_in '確認用パスワード', with: 'newpassword2'
          click_button '更新する'
          expect(page).to have_content '入力に誤りがあります'
        end
      end
    end
  end
end
