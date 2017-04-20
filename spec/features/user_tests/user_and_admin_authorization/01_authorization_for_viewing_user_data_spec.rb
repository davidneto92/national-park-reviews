require "rails_helper"

feature "users must be signed in to user information" do
  scenario "users must be signed in to view any user's information" do
    user_01 = FactoryGirl.create(:user)
    user_02 = FactoryGirl.create(:user)

    visit "/users/#{user_01.id}"
    expect(page).to have_content("The page you were looking for doesn't exist.")
    expect(page).to_not have_content("#{user_01.email}")
    visit "/users/#{user_02.id}"
    expect(page).to have_content("The page you were looking for doesn't exist.")
    expect(page).to_not have_content("#{user_02.email}")
  end

  scenario "signed in users can view a user's page" do
    user_01 = FactoryGirl.create(:user)
    user_02 = FactoryGirl.create(:user)

    login_as(user_01)
    visit "/users/#{user_02.id}"

    expect(page).to_not have_content("Not authorized. Please sign in to view this user.")
    expect(page).to have_content("#{user_02.email}")
  end

  scenario "user page lists links to given user's submitted parks" do
    user_01 = FactoryGirl.create(:user)
    user_02 = FactoryGirl.create(:user)
    park_01 = FactoryGirl.create(:park, user_id: user_01.id, main_image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/mountains_01.jpg'))))
    park_02 = FactoryGirl.create(:park, user_id: user_01.id, main_image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/mountains_02.jpg'))))

    login_as(user_02)
    visit "/users/#{user_01.id}"

    expect(page).to have_content("Submitted Parks")
    expect(page).to have_link("#{park_01.name}")
    expect(page).to have_link("#{park_02.name}")
  end

end
