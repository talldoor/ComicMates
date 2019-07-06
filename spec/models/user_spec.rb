require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーションの確認' do
    before do
      @user = FactoryBot.create(:user)
    end

    context 'ユーザーが有効であるとき' do
      it 'メールアドレスとパスワードを共に設定している' do
        expect(@user).to be_valid
      end

      it '名前を設定している' do
        @user.name = 'テストユーザー'
        expect(@user.name).to eq 'テストユーザー'
      end

      it 'メールアドレスが重複していない' do
        @user2 = FactoryBot.create(:user, email: 'test111@example.com')
        expect(@user).to be_valid
      end
    end

    context 'ユーザーが無効であるとき' do
      it 'メールアドレスを設定していない' do
        @user.email = nil
        expect(@user).not_to be_valid
      end

      it 'メールアドレスが重複している' do
        @user2 = FactoryBot.create(:user, email: 'test111@example.com')
        @user.email = 'test111@example.com'
        expect(@user).not_to be_valid
      end
    end
  end
end
