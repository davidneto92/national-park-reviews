require "rails_helper"

feature "admin accounts delete park entries" do
  scenario "admin are able to delete parks" do
    user_01 = FactoryGirl.create(:user)
    user_02 = FactoryGirl.create(:user, role: "admin")
    park_01 = FactoryGirl.create(:park, user_id: user_01.id, main_image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/mountains_01.jpg'))))
    park_02 = FactoryGirl.create(:park, user_id: user_01.id, main_image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/mountains_01.jpg'))))

    login_as(user_02)
    visit "/parks"

    click_link("Delete Park", match: :first)

    expect(Park.all.include?(park_01)).to be false
  end

  scenario "standard users cannot delete parks" do
    user_01 = FactoryGirl.create(:user)
    park_01 = FactoryGirl.create(:park, user_id: user_01.id, main_image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/mountains_01.jpg'))))
    park_02 = FactoryGirl.create(:park, user_id: user_01.id, main_image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/mountains_01.jpg'))))

    login_as(user_01)
    visit "/parks"
    expect(page).to_not have_link("Delete Park")
    expect(Park.all.include?(park_01)).to be true
  end
end
