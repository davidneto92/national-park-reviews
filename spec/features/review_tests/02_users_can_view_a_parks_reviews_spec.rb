require "rails_helper"

feature "users can view all reviews of parks" do
  scenario "all users can see all reviews of a park" do
    user_01 = FactoryGirl.create(:user)
    user_02 = FactoryGirl.create(:user)
    park_01 = FactoryGirl.create(:park, user_id: user_01.id, main_image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/mountains_01.jpg'))))
    review_01 = FactoryGirl.create(:review, user_id: user_01.id, park_id: park_01.id)
    review_02 = FactoryGirl.create(:review, user_id: user_02.id, park_id: park_01.id)

    login_as(user_02)

    visit "parks/#{park_01.id}"
    expect(page).to have_link("#{user_01.display_name}")
    expect(page).to have_content("#{review_01.title}")
    expect(page).to have_content("#{review_01.body}")
    expect(page).to have_link("#{user_02.display_name}")
    expect(page).to have_content("#{review_02.title}")
    expect(page).to have_content("#{review_02.body}")
  end

  scenario "reviews show user's display name if available" do
    user_01 = FactoryGirl.create(:user, display_name: "Luke_Skywalker")
    park_01 = FactoryGirl.create(:park, user_id: user_01.id, main_image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/mountains_01.jpg'))))
    review_01 = FactoryGirl.create(:review, user_id: user_01.id, park_id: park_01.id)

    login_as(user_01)

    visit "parks/#{park_01.id}"
    expect(page).to have_link("#{user_01.display_name}")
    expect(page).to have_content("#{review_01.title}")
  end

  scenario "reviews display user avatar" do
    user_01 = FactoryGirl.create(:user, display_name: "Leia_Organa", avatar: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/test_author_avatar.jpg'))))
    park_01 = FactoryGirl.create(:park, user_id: user_01.id, main_image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/mountains_01.jpg'))))
    review_01 = FactoryGirl.create(:review, user_id: user_01.id, park_id: park_01.id)

    login_as(user_01)

    visit "parks/#{park_01.id}"
    expect(page).to have_link("#{user_01.display_name}")
    expect(page).to have_content("#{review_01.title}")
    expect(page).to have_css("img[src*='test_author_avatar.jpg']")
  end

  scenario "user pages list reviewed parks & visit date" do
    user_01 = FactoryGirl.create(:user)
    park_01 = FactoryGirl.create(:park, user_id: user_01.id, main_image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/mountains_01.jpg'))))
    park_02 = FactoryGirl.create(:park, user_id: user_01.id, main_image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/mountains_01.jpg'))))
    review_01 = FactoryGirl.create(:review, user_id: user_01.id, park_id: park_01.id)
    review_02 = FactoryGirl.create(:review, user_id: user_01.id, park_id: park_02.id)

    user_02 = FactoryGirl.create(:user)
    login_as(user_02)

    visit "users/#{user_01.id}"

    expect(page).to have_content("Submitted Parks")

    expect(page).to have_link("#{park_01.name}")
    expect(page).to have_content("#{review_01.title}")

    expect(page).to have_link("#{park_02.name}")
    expect(page).to have_content("#{review_02.title}")
  end
end
