require "rails_helper"

feature "users and admin can edit reviews of parks" do
  scenario "signed in users can edit a review they created" do
    user_01 = FactoryGirl.create(:user)
    park_01 = FactoryGirl.create(:park, user_id: user_01.id, main_image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/mountains_01.jpg'))))
    review_01 = FactoryGirl.create(:review, user_id: user_01.id, park_id: park_01.id)

    login_as(user_01)
    visit "parks/#{park_01.id}"

    expect(page).to have_content(review_01.title)
    expect(page).to have_content(review_01.body)

    click_link("Edit Review")

    fill_in "Review Title", with: "My new and improved revised title"
    fill_in "Your Review", with: "Forgot to mention I love this park!!! Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin bibendum eu dui at euismod. Nulla ac augue enim."
    select "2005", from: "review[visit_date(1i)]"
    select "February", from: "review[visit_date(2i)]"
    select "21", from: "review[visit_date(3i)]"

    click_button("Submit Review")

    expect(page).to have_content("Review successfully updated.")
    expect(page).to have_content("My new and improved revised title")
  end

  scenario "users cannot edit reviews by other users" do
    user_01 = FactoryGirl.create(:user)
    park_01 = FactoryGirl.create(:park, user_id: user_01.id, main_image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/mountains_01.jpg'))))
    review_01 = FactoryGirl.create(:review, user_id: user_01.id, park_id: park_01.id)

    visit "parks/#{park_01.id}"
    expect(page).to_not have_link("Edit Review")

    visit "/parks/#{park_01.id}/reviews/#{review_01.id}/edit"
    expect(page).to have_content("The page you were looking for doesn't exist.")
    expect(page).to_not have_field("Review Title")
  end

  scenario "admin accounts can edit any review" do
    user_01 = FactoryGirl.create(:user)
    user_02 = FactoryGirl.create(:user, role: "admin")
    park_01 = FactoryGirl.create(:park, user_id: user_01.id, main_image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/mountains_01.jpg'))))
    review_01 = FactoryGirl.create(:review, user_id: user_01.id, park_id: park_01.id)

    login_as(user_02)
    visit "parks/#{park_01.id}"

    expect(page).to have_content(review_01.title)
    expect(page).to have_content(review_01.body)

    click_link("Edit Review")

    fill_in "Review Title", with: "My new and improved revised title"
    fill_in "Your Review", with: "Forgot to mention I love this park!!! Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin bibendum eu dui at euismod. Nulla ac augue enim."
    select "2005", from: "review[visit_date(1i)]"
    select "February", from: "review[visit_date(2i)]"
    select "21", from: "review[visit_date(3i)]"

    click_button("Submit Review")

    expect(page).to have_content("Review successfully updated.")
    expect(page).to have_content("My new and improved revised title")
  end

end
