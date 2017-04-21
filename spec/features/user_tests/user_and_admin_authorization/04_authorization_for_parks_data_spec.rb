require "rails_helper"

# NOTE: These tests are for authorization; the ability to edit a park is tested
# in spec/features/park_tests/
feature "users must have access to edit park information" do
  scenario "users must be signed in to edit park information" do
    user_01 = FactoryGirl.create(:user)
    park_01 = FactoryGirl.create(:park, user_id: user_01.id, main_image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/mountains_01.jpg'))))

    visit "/parks/#{park_01.id}"
    expect(page).to_not have_link("Edit Park")

    visit "/parks/#{park_01.id}/edit"
    expect(page).to have_content("The page you were looking for doesn't exist.")
  end

  scenario "users are authorized to edit information of parks they created" do
    user_01 = FactoryGirl.create(:user)
    park_01 = FactoryGirl.create(:park, user_id: user_01.id, main_image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/mountains_01.jpg'))))
    login_as(user_01)

    visit "/parks/#{park_01.id}/edit"
    expect(page).to_not have_content("The page you were looking for doesn't exist.")
    expect(page).to have_content("Edit listing for #{park_01.name}")
    expect(page).to have_field("Park Name")
  end

  scenario "users cannot edit information of parks created by other users" do
    user_01 = FactoryGirl.create(:user)
    user_02 = FactoryGirl.create(:user)
    park_01 = FactoryGirl.create(:park, user_id: user_01.id, main_image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/mountains_01.jpg'))))

    login_as(user_02)
    visit "/parks/#{park_01.id}/edit"
    expect(page).to have_content("The page you were looking for doesn't exist.")
    expect(page).to_not have_content("Edit listing for #{park_01.name}")
    expect(page).to_not have_field("Park Name")    
  end
end
