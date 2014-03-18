# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :beer do
    name 'Enscorcelled'
    inventory 1
    brewery
  end
end
