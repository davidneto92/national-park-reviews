require "rails_helper"

feature "park index page paginates listings" do
  scenario "index shows first 10 parks alphabetically" do
    user = FactoryGirl.create(:user)
    park_01 = FactoryGirl.create(:park, user_id: user.id, main_image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/mountains_01.jpg'))))
    park_02 = FactoryGirl.create(:park, user_id: user.id, main_image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/mountains_01.jpg'))))
    park_03 = FactoryGirl.create(:park, user_id: user.id, main_image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/mountains_01.jpg'))))
    park_04 = FactoryGirl.create(:park, user_id: user.id, main_image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/mountains_01.jpg'))))
    park_05 = FactoryGirl.create(:park, user_id: user.id, main_image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/mountains_01.jpg'))))
    park_06 = FactoryGirl.create(:park, user_id: user.id, main_image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/mountains_01.jpg'))))
    park_07 = FactoryGirl.create(:park, user_id: user.id, main_image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/mountains_01.jpg'))))

    visit "/parks"

    expect(page).to have_link("#{park_01.name}")
    expect(page).to have_link("#{park_02.name}")
    expect(page).to have_link("#{park_03.name}")
    expect(page).to have_link("#{park_04.name}")
    expect(page).to have_link("#{park_05.name}")

    expect(page).to_not have_link("#{park_06.name}")
    expect(page).to_not have_link("#{park_07.name}")
  end

  scenario "index shows remaining parks on subsequent pages, alphabetically" do
    user = FactoryGirl.create(:user)
    # because it sorts "alphabetically", using the sequence would sort factory objects
    # as Park 01, 10, 12 etc.
    park_01 = FactoryGirl.create(:park, name: "Park A", user_id: user.id, main_image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/mountains_01.jpg'))))
    park_02 = FactoryGirl.create(:park, name: "Park B", user_id: user.id, main_image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/mountains_01.jpg'))))
    park_03 = FactoryGirl.create(:park, name: "Park C", user_id: user.id, main_image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/mountains_01.jpg'))))
    park_04 = FactoryGirl.create(:park, name: "Park D", user_id: user.id, main_image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/mountains_01.jpg'))))
    park_05 = FactoryGirl.create(:park, name: "Park E", user_id: user.id, main_image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/mountains_01.jpg'))))
    park_06 = FactoryGirl.create(:park, name: "Park F", user_id: user.id, main_image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/mountains_01.jpg'))))
    park_07 = FactoryGirl.create(:park, name: "Park G", user_id: user.id, main_image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/mountains_01.jpg'))))

    visit "/parks/?page=2"

    expect(page).to_not have_link("#{park_01.name}")
    expect(page).to_not have_link("#{park_02.name}")

    expect(page).to have_link("#{park_06.name}")
    expect(page).to have_link("#{park_07.name}")
  end
end
