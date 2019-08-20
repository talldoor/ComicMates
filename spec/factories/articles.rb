FactoryBot.define do
  factory :article do
    comic_title { 'C_title' }
    comic_author { 'C_Author' }
    overview { 'C_Overview' }
    detail { 'C_Detail' }
    association :user
  end
end
