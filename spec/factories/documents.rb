include ActionDispatch::TestProcess

FactoryBot.define do
  factory :document do
    sequence(:name) { |x| "test_file_factory#{x}" }
    status { 'Waiting' }
    association :user
    file { fixture_file_upload("#{Rails.root}/public/test_csv.csv", 'text/csv') }

    trait :processing do
      status { 'Processing' }
    end

    trait :success do
      status { 'Success' }
    end

    trait :failed do
      status { 'Failed' }
    end

    trait :invalid_document do
      name { '' }
      status { '' }
    end
  end
end
