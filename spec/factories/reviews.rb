# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :review do
    rating 1
    comment 'Some comment'
    beer
    user
  end
end
