FactoryBot.define do
  factory :article do
    comic_title { 'MyString' }
    comic_author { 'MyString' }
    overview { 'MyText' }
    detail { 'MyText' }
    association :user
  end
end
