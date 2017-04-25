FactoryGirl.define do
  factory :park do
    sequence(:name) { |n| "National Park 0#{n}" }
    main_image Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/mountains_01.jpg')))
    state "South Dakota"
    user_id 1
  end
end
