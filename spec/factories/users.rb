# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name 'Testy McTesterson'
    sequence(:email) { |s| "test-#{s}@palominolabs.com" }
    password 'test'
    password_confirmation 'test'
  end
end
