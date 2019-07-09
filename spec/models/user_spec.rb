require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーションの確認' do
    before do
      @user = FactoryBot.create(:user)
    end

    context 'ユーザーが有効であるとき' do
      it 'ユーザ名が存在する' do
        expect(@user).to be_valid
      end

      it 'ユーザ名の長さが範囲内' do
        @user.name = '12345678901234567890'
        expect(@user).to be_valid
      end

      it 'メールアドレスが重複していない' do
        @user2 = FactoryBot.create(:user, email: 'test111@example.com')
        expect(@user).to be_valid
      end
    end

    context 'ユーザーが無効であるとき' do
      it 'ユーザ名が存在しない' do
        @user.name = nil
        expect(@user).not_to be_valid
      end

      it 'ユーザ名の長さが範囲外' do
        @user.name = '123456789012345678901'
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
