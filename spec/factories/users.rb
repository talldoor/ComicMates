FactoryBot.define do
  factory :user do
    email { 'test000@example.com' }
    password { 'password' }
    password_confirmation { 'password' }
    name { 'ユーザーA' }
  end

  factory :other_user, class: 'User' do
    email { 'test111@example.com' }
    password { 'password' }
    password_confirmation { 'password' }
    name { 'アザーユーザー' }
  end

  factory :test_user, class: 'User' do
    email { 'testuser@vwxyz.com' }
    password { 'test39pass' }
    password_confirmation { 'test39pass' }
    name { '簡易ログイン用' }
  end
end
