require "rails_helper"

feature "users can edit their account details" do
  scenario "users can change the display name for their account" do
    user_01 = FactoryGirl.create(:user)
    login_as(user_01)
    visit "/users/#{user_01.id}"

    expect(page).to have_content("Display Name: not set")

    click_link "Edit Display Name and Avatar"
    fill_in "Display Name", with: "test name"
    click_button "Submit"

    expect(page).to have_content("Display Name: test name")
  end

  scenario "users can remove the display name from their account" do
    user_01 = FactoryGirl.create(:user, display_name: "Mountain_man")
    login_as(user_01)
    visit "/users/#{user_01.id}"

    expect(page).to have_content("Display Name: Mountain_man")

    click_link "Edit Display Name and Avatar"
    fill_in "Display Name", with: ""
    click_button "Submit"

    expect(page).to have_content("Display Name: not set")
  end

  scenario "users can change their password" do
    user_01 = FactoryGirl.create(:user)
    login_as(user_01)

    visit "/users/#{user_01.id}"
    click_link "Manage Sign in Details"

    fill_in "Password", with: "newpassword"
    fill_in "Password confirmation", with: "newpassword"
    fill_in "Current password", with: "password"
    click_button "Update"

    expect(page).to have_content("Your account has been updated successfully.")
    # expect(User.all.last.password).to eq("newpassword")
    # I can't figure out how to validate that the password changed besides
    # using the following block:

    click_link "Sign out"
    click_link "Sign in"
    fill_in "Email", with: user_01.email
    fill_in "Password", with: "newpassword"
    click_on "Log in"
    expect(page).to have_content("Log in successful.")
  end

  scenario "users can change their login email" do
    user_01 = FactoryGirl.create(:user)
    login_as(user_01)

    visit "/users/#{user_01.id}"
    click_link "Manage Sign in Details"

    fill_in "Email", with: "new_email@email.com"
    fill_in "Current password", with: user_01.password
    click_button "Update"

    expect(page).to have_content("Your account has been updated successfully.")
    expect(User.all.last.email).to eq("new_email@email.com")
  end

  scenario "users cannot edit another user's information" do
    user_01 = FactoryGirl.create(:user)
    user_02 = FactoryGirl.create(:user)

    login_as(user_02)
    visit "/users/#{user_01.id}"
    expect(page).to_not have_link("Edit Your Information")

    visit "/users/#{user_01.id}/edit"
    expect(page).to have_content("The page you were looking for doesn't exist.")
  end
end
