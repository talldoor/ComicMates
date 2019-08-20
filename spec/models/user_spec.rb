require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーションの確認' do
    before do
      @user = FactoryBot.create(:user)
    end

    context 'ユーザーが有効' do
      it '必須項目が全て存在する' do
        expect(@user).to be_valid
      end

      it 'ユーザ名の文字数が範囲内' do
        @user.name = 'a' * 20
        expect(@user).to be_valid
      end

      it 'メールアドレスが重複していない' do
        @user2 = FactoryBot.create(:user, email: 'test111@example.com')
        expect(@user).to be_valid
      end
    end

    context 'ユーザーが無効' do
      it 'ユーザ名が存在しない' do
        @user.name = nil
        expect(@user).not_to be_valid
      end

      it 'ユーザ名の文字数オーバー' do
        @user.name = 'a' * 21
        expect(@user).not_to be_valid
      end

      it 'メールアドレスが重複している' do
        @user2 = FactoryBot.create(:user, email: 'test111@example.com')
        @user.email = 'test111@example.com'
        expect(@user).not_to be_valid
      end

      it 'パスワードが存在しない' do
        @user.password = ''
        expect(@user).not_to be_valid
      end

      it 'パスワードが最低文字数を未満' do
        @user.password = 'ppppp'
        @user.password_confirmation = 'ppppp'
        expect(@user).not_to be_valid
      end

      it 'お気に入り作品の文字数オーバー' do
        @user.my_book1 = 'a' * 21
        expect(@user).not_to be_valid
      end

      it '自己紹介の文字数オーバー' do
        @user.name = 'a' * 151
        expect(@user).not_to be_valid
      end
    end
  end
end
