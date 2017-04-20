FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "example_#{n}@email.com" }
    password "password"
    # display_name ""
  end
end
