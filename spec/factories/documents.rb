FactoryBot.define do
  factory :document do
    sequence(:name) { |x| "test_file_factory#{x}" }
    status {"Waiting"}
    association :user

    trait :processing do
      status {"Processing"}
    end

    trait :success do
      status {"Success"}
    end

    trait :failed do
      status {"Failed"}
    end

  end
end
