FactoryBot.define do
  factory :user do
    sequence(:email) { |x| "email#{x}@gmail.com" }
    password { '123456789' }

    trait :with_contacts do
      after(:create) { |user| create_list(:contact, 5, user: user) }
    end

    trait :no_email do
      email { nil }
    end

    trait :duplicate_email do
      email { 'email1@gmail.com' }
    end
  end
end
