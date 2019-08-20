require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'バリデーションの確認' do
    before do
      @comment = FactoryBot.create(:comment)
    end

    context 'コメントが有効' do
      it 'コメントの文字数が範囲内' do
        expect(@comment).to be_valid
      end

      it 'リレーションが正しく行わている' do
        expect(@comment.user.name).to eq 'アザーユーザー'
        expect(@comment.article.comic_title).to eq 'C_title'
      end
    end

    context 'コメントが無効' do
      it 'コメント内容が存在しない' do
        @comment.content = nil
        expect(@comment).not_to be_valid
      end

      it 'コメントの文字数オーバー' do
        @comment.content = 'a' * 51
        expect(@comment).not_to be_valid
      end
    end
  end
end
