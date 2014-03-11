# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :review do
    reviewer "MyString"
    rating 1
    comment "MyText"
    beer
  end
end
