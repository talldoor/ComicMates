require 'rails_helper'

describe 'ログアウト機能', type: :system do
  before do
    sign_in_as FactoryBot.create(:user)
  end

  context '「ログアウト」を押下した場合' do
    it 'ログアウトする' do
      find('#navbarDropdown').click
      click_on 'ログアウト'
      expect(page).to have_content 'ログアウトしました'
    end
  end
end
