FactoryBot.define do
  factory :user do
    email { 'test000@example.com' }
    password { 'password' }
    password_confirmation { 'password' }
    name { 'テストユーザー' }
  end
end
