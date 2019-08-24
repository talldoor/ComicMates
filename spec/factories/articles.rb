FactoryBot.define do
  factory :article do
    comic_title { 'C_title' }
    comic_author { 'C_author' }
    overview { 'C_overview' }
    detail { 'C_detail' }
    user
  end

  factory :other_article, class: 'Article' do
    # comic_title { 'C_other_title' }
    sequence(:comic_title) { |n| "C_other_title_#{n}" }
    comic_author { 'C_other_author' }
    overview { 'C_other_overview' }
    detail { 'C_other_detail' }
    user
  end
end
