require "rails_helper"

feature "user can create a park" do
  scenario "signed in user can create a park" do
    user = FactoryGirl.create(:user)
    visit "/"
    click_link "Sign in"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_on "Log in"

    click_link "Add a Park"

    expect(page).to have_content("Add a new National Park")
    fill_in "Park Name", with: "Arches National Park"
    select "Utah", from: "State"
    attach_file("Park Image", "#{Rails.root}/spec/support/upload_test_picture.jpg")
    click_button "Submit"

    expect(page).to have_content("Arches National Park created!")
    expect(page).to have_content("Arches National Park")
    expect(page).to have_content("Utah")
    expect(page).to have_css("img[src*='upload_test_picture.jpg']")
  end

  scenario "users cannot create a park that already exists" do
    user = FactoryGirl.create(:user)
    visit "/"
    click_link "Sign in"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_on "Log in"

    click_link "Add a Park"

    expect(page).to have_content("Add a new National Park")
    fill_in "Park Name", with: "Arches National Park"
    select "Utah", from: "State"
    attach_file("Park Image", "#{Rails.root}/spec/support/upload_test_picture.jpg")
    click_button "Submit"

    click_link "Add a Park"

    fill_in "Park Name", with: "Arches National Park"
    select "Utah", from: "State"
    attach_file("Park Image", "#{Rails.root}/spec/support/upload_test_picture.jpg")
    click_button "Submit"

    expect(page).to_not have_content("Arches National Park created!")
    expect(page).to have_content("This park has already been created.")
  end

  # access to park creation tested in users spec
end
