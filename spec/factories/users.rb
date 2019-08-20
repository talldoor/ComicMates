FactoryBot.define do
  factory :user do
    email { 'test000@example.com' }
    password { 'password' }
    password_confirmation { 'password' }
    name { 'テストユーザー' }
  end

  factory :other_user, class: 'User' do
    email { 'test111@example.com' }
    password { 'password' }
    password_confirmation { 'password' }
    name { 'アザーユーザー' }
  end
end
