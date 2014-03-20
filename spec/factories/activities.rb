# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :beer_opened_activity do
    user
    beer
  end

  factory :beer_added_activity do
    user
    beer
  end

  factory :beer_reviewed_activity do
    review
  end
end
