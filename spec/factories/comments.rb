FactoryBot.define do
  factory :comment do
    content { "MyComment" }
    association :user, factory: :other_user
    association :article
  end
end
