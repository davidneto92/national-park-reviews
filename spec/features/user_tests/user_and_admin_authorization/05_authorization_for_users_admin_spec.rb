require "rails_helper"

feature "admin accounts can edit user information" do
  scenario "admin accounts can view index of users" do
    user_01 = FactoryGirl.create(:user)
    user_02 = FactoryGirl.create(:user)
    user_03 = FactoryGirl.create(:user)
    user_04 = FactoryGirl.create(:user, role: "admin")

    login_as(user_04)
    visit "/users"
    expect(page).to_not have_content("The page you were looking for doesn't exist.")
    expect(page).to have_link("#{user_01.email}")
    expect(page).to have_link("#{user_02.email}")
    expect(page).to have_link("#{user_03.email}")
  end

  scenario "admin can change the display name for an account" do
    user_01 = FactoryGirl.create(:user)
    user_02 = FactoryGirl.create(:user, role: "admin")

    login_as(user_02)
    visit "/users/#{user_01.id}"

    click_link "Edit Display Name and Avatar"
    fill_in "Display Name", with: "test name by admin"
    click_button "Submit"

    expect(page).to have_content("Display Name: test name by admin")
  end

  scenario "admin can remove the display name from an account" do
    user_01 = FactoryGirl.create(:user, display_name: "Mountain_man")
    user_02 = FactoryGirl.create(:user, role: "admin")
    login_as(user_02)
    visit "/users/#{user_01.id}"

    expect(page).to have_content("Display Name: Mountain_man")

    click_link "Edit Display Name and Avatar"
    fill_in "Display Name", with: ""
    click_button "Submit"

    expect(page).to have_content("Display Name: not set")
  end

end
