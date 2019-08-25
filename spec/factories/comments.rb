FactoryBot.define do
  factory :comment do
    content { "MyComment" }
    user
    article
  end
end
