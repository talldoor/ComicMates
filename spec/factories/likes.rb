FactoryBot.define do
  factory :like do
    trait :with_dependents do
      user
      article
    end
  end
end
