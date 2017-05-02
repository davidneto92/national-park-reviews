require "rails_helper"

feature "users can search through the parks" do
  scenario "entering search terms will return relevant parks" do
    user_01 = FactoryGirl.create(:user)
    park_01 = FactoryGirl.create(:park, name: "Grand Canyon National Park", state: "Arizona", user_id: user_01.id, main_image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/mountains_01.jpg'))))
    park_02 = FactoryGirl.create(:park, name: "Saguaro National Park", state: "Arizona", user_id: user_01.id, main_image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/mountains_02.jpg'))))

    visit "/"

    fill_in "Search Parks:", with: "Grand"
    click_button "Search"

    expect(page).to have_link("Grand Canyon National Park")
    # expect(page).to_not have_link("Saguaro National Park")
    expect(page).to_not have_xpath("//div[.=index-display]/..", text: "Saguaro National Park")


  end

  scenario "entering search terms matching multiple parks will return all results" do
    user_01 = FactoryGirl.create(:user)
    park_01 = FactoryGirl.create(:park, name: "Bryce Canyon National Park", state: "Utah", user_id: user_01.id, main_image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/mountains_01.jpg'))))
    park_02 = FactoryGirl.create(:park, name: "Zion National Park", state: "Utah", user_id: user_01.id, main_image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/mountains_02.jpg'))))
    park_03 = FactoryGirl.create(:park, name: "Everglades National Park", state: "Florida", user_id: user_01.id, main_image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/mountains_02.jpg'))))

    visit "/"

    fill_in "Search Parks:", with: "Utah"
    click_button "Search"

    expect(page).to have_link("Zion National Park")
    expect(page).to have_link("Bryce Canyon National Park")
    expect(page).to_not have_xpath("//div[.=index-display]/..", text: "Everglades National Park")
  end

  scenario "entering unrelated search terms will no return relevant parks" do
    user_01 = FactoryGirl.create(:user)
    park_01 = FactoryGirl.create(:park, name: "Grand Canyon", state: "AZ", user_id: user_01.id, main_image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/mountains_01.jpg'))))
    park_02 = FactoryGirl.create(:park, name: "Saguaro", state: "AZ", user_id: user_01.id, main_image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/mountains_02.jpg'))))

    visit "/"

    fill_in "Search Parks:", with: "Yosemite"
    click_button "Search"

    expect(page).to have_content("No results found for Yosemite")
    expect(page).to_not have_xpath("//div[.=index-display]/..", text: "Saguaro National Park")
    expect(page).to_not have_xpath("//div[.=index-display]/..", text: "Grand Canyon National Park")
  end
end
