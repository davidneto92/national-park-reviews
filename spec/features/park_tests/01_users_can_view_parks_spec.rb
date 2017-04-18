require "rails_helper"

feature "users can view park(s)" do
  scenario "signed in users can view index page that lists all parks" do
    user = FactoryGirl.create(:user)
    park_01 = FactoryGirl.create(:park, main_image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/mountains_01.jpg'))))
    park_02 = FactoryGirl.create(:park, main_image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/mountains_02.jpg'))))

    visit "/"
    click_link "Sign in"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_on "Log in"

    expect(page).to have_content(park_01.name)
    expect(page).to have_content(park_02.name)
    expect(page).to have_content(park_01.state)
    expect(page).to have_content(park_02.state)
    expect(page).to have_css("img[src*='mountains_01.jpg']")
    expect(page).to have_css("img[src*='mountains_02.jpg']")
  end

  scenario "non-signed in users can view index page that lists all parks" do
    user = FactoryGirl.create(:user)
    park_01 = FactoryGirl.create(:park, user_id: 2, main_image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/mountains_01.jpg'))))
    park_02 = FactoryGirl.create(:park, user_id: 2, main_image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/mountains_02.jpg'))))

    visit "/"

    expect(page).to have_content(park_01.name)
    expect(page).to have_content(park_02.name)
    expect(page).to have_content(park_01.state)
    expect(page).to have_content(park_02.state)
    expect(page).to have_css("img[src*='mountains_01.jpg']")
    expect(page).to have_css("img[src*='mountains_02.jpg']")
  end

  scenario "index page links to each show page for each displayed park" do
    user = FactoryGirl.create(:user)
    park_01 = FactoryGirl.create(:park, user_id: 3, main_image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/mountains_01.jpg'))))

    visit "/"

    # checks for a text link and a picture link
    expect(page).to have_link(park_01.name)
    expect(page).to have_xpath("//a/img[@alt='link to park']")
  end

  pending "park index is paginated" # to be added
end
