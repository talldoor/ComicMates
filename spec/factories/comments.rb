FactoryBot.define do
  factory :comment do
    content { "MyString" }
    user { nil }
    article { nil }
  end
end
