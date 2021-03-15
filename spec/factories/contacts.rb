FactoryBot.define do
  factory :contact do
    name { 'Factory contact-name' }
    birthdate { 21.years.ago }
    phone { '(+57) 333 333 33 33' }
    address { 'Valid factory address' }
    sequence(:email) { |x| "email#{x}@factory.com" }
    credit_card { '4111111111111111' }
    association :user

    trait :birthdate_100_year_ago do
      birthdate { 100.years.ago }
    end

    trait :invalid_contact do
      name { 'invalid_name' }
      birthdate { 'invalid date' }
      phone { 'invalid phone' }
      address { nil }
      email { 'invalid email @' }
      credit_card { '411111111111111' }
    end
  end
end
