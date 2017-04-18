FactoryGirl.define do
  factory :park do
    sequence(:name) { |n| "National Park #{n}" }
    main_image Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/mountains_01.jpg')))
    state "SD"
    user_id 1

    after :create do |b|
      b.update_column(:main_image, "#{Rails.root}/spec/support/mountains_01.jpg")
    end

  end
end
