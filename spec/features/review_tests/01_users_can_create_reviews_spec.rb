require "rails_helper"

feature "users can create reviews of parks" do
  scenario "signed in user can successfully create a review for any park" do
    user_01 = FactoryGirl.create(:user)
    user_02 = FactoryGirl.create(:user)
    park_01 = FactoryGirl.create(:park, user_id: user_01.id, main_image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/mountains_01.jpg'))))
    login_as(user_02)

    visit "/parks/#{park_01.id}"
    click_link("Write a Review")

    fill_in "Review Title", with: "My review of the Park"
    fill_in "Your Review", with: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin bibendum eu dui at euismod. Nulla ac augue enim."
    select "2014", from: "review[visit_date(1i)]"
    select "June", from: "review[visit_date(2i)]"
    select "13", from: "review[visit_date(3i)]"

    click_button("Submit Review")

    expect(page).to have_content("Review created!")
    expect(page).to have_content("By: #{user_02.email}")
    expect(page).to have_content("My review of the Park")
    expect(page).to have_content("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin bibendum eu dui at euismod. Nulla ac augue enim.")
    expect(page).to have_content("Date of Visit: 06/13/2014")
  end

  scenario "review not created if insufficient input supplied" do
    user_01 = FactoryGirl.create(:user)
    user_02 = FactoryGirl.create(:user)
    park_01 = FactoryGirl.create(:park, user_id: user_01.id, main_image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/mountains_01.jpg'))))
    login_as(user_02)

    visit "/parks/#{park_01.id}"
    click_link("Write a Review")

    fill_in "Review Title", with: "Short title"
    fill_in "Your Review", with: "This review is much too short"
    # this date is currently later than the testing date, so an error should be found
    select "2017", from: "review[visit_date(1i)]"
    select "June", from: "review[visit_date(2i)]"
    select "13", from: "review[visit_date(3i)]"

    click_button("Submit Review")
    expect(page).to_not have_content("Review created!")
    expect(page).to have_content("3 errors prevented your review from being saved")
    expect(page).to have_content("Title is too short (minimum is 20 characters)")
    expect(page).to have_content("Body is too short (minimum is 100 characters")
  end

  scenario "non-signed in user cannot create a review" do
    user_01 = FactoryGirl.create(:user)
    park_01 = FactoryGirl.create(:park, user_id: user_01.id, main_image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/mountains_01.jpg'))))

    visit "/parks/#{park_01.id}"
    expect(page).to_not have_link("Write a Review")

    visit "/parks/#{park_01.id}/reviews/new"
    expect(page).to have_content("The page you were looking for doesn't exist.")
  end
end
