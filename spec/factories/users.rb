FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "example_#{n}@email.com" }
    password "password"
    sequence(:display_name) { |n| "username_#{n}" }
  end
end
