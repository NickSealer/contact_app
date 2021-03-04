FactoryBot.define do
  factory :contact do
    name { "Factory contact-name" }
    birthdate { 21.years.ago }
    phone { "(+57) 333 333 33 33" }
    address { "Valid factory record" }
    sequence(:email) { |x| "email#{x}@factory.com" }
    credit_card { "4111111111111111" }
    association :user

    trait :birthdate_100_year_ago do
      birthdate { 100.years.ago }
    end
  end

end
