FactoryBot.define do
  factory :user do
    name { 'ユーザーA' }
    email { 'test000@example.com' }
    password { 'password' }
    password_confirmation { 'password' }
  end

  factory :other_user, class: 'User' do
    sequence(:name) { |n| "アザーユーザー_#{n}" }
    sequence(:email) { |n| "other_#{n}@example.com" }
    password { 'password' }
    password_confirmation { 'password' }
    my_book1 { 'マイベスト１' }
    my_book2 { 'マイベスト２' }
    my_book3 { 'マイベスト３' }
    self_introduction { '自己紹介文' }
  end

  factory :test_user, class: 'User' do
    name { '簡易ログイン用' }
    email { 'testuser@vwxyz.com' }
    password { 'test39pass' }
    password_confirmation { 'test39pass' }
  end
end
