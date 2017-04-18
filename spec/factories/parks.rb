FactoryGirl.define do
  factory :park do
    sequence(:name) { |n| "National Park #{n}" }
    main_image "https://www.nationalparks.org/sites/default/files/styles/wide_1x/public/badlands_harlanhumphrey_ste.jpg?itok=su3Bgprf&timestamp=1485285621"
    state "SD"
    user_id 1
  end
end
