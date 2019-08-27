require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:other_user) }
  let(:article) { FactoryBot.create(:article, user: other_user) }
  let(:like) do
    FactoryBot.create(:like, user: user, article: article)
  end

  context 'リレーションが正しく行わているとき' do
    it 'ユーザーの名前と記事のタイトルが正しいこと' do
      expect(like).to be_valid
      expect(like.user.name).to eq user.name
      expect(like.article.comic_title).to eq article.comic_title
    end
  end
end
