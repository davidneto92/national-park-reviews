FactoryGirl.define do
  factory :review do
    sequence(:title) { |n| "My review of the Park #{n}" }
    body "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin bibendum eu dui at euismod. Nulla ac augue enim."
    visit_date (Time.now - 50000)
  end
end
