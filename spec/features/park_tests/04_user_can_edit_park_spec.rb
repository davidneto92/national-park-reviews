require "rails_helper"

feature "user can edit a park" do
  scenario "creator of park can edit park information" do
    user = FactoryGirl.create(:user)
    park_01 = FactoryGirl.create(:park, user_id: user.id, year_founded: 1939, area_miles: 379,
      main_image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/mountains_01.jpg'))))

    visit "/"
    click_link "Sign in"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_on "Log in"

    first(:link, "#{park_01.name}").click

    click_link("Edit Park")

    fill_in "Park Name", with: "the NEW park!"
    select "Idaho", from: "State"
    attach_file("Park Image", "#{Rails.root}/spec/support/upload_test_picture.jpg")
    fill_in "Year Founded", with: 2017
    fill_in "Area in sq miles", with: 201

    click_button "Submit"

    expect(page).to have_content("the NEW park!")
    expect(page).to have_content("Idaho")
    expect(page).to have_content("Year Founded: 2017")
    expect(page).to have_content("Area (miles2): 201")
    expect(page).to have_css("img[src*='upload_test_picture.jpg']")
  end

  # RSpec has trouble accessing current_user, so I do not know a better way to validate
  # the logic used to display the edit link.
  scenario "non-creators or non-admin users cannot edit park info" do
    user_01 = FactoryGirl.create(:user)
    user_02 = FactoryGirl.create(:user)
    park_01 = FactoryGirl.create(:park, user_id: user_01.id, year_founded: 1939, area_miles: 379,
      main_image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/mountains_01.jpg'))))

    visit "/"
    click_link "Sign in"
    fill_in "Email", with: user_02.email
    fill_in "Password", with: user_02.password
    click_on "Log in"

    first(:link, "#{park_01.name}").click

    expect(page).to_not have_link("Edit Park")
  end
end
