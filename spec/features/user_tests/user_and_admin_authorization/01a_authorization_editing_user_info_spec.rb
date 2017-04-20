require "rails_helper"

feature "users can edit their account details" do
  scenario "users can change the display name for their account" do
    user_01 = FactoryGirl.create(:user)
    login_as(user_01)
    visit "/users/#{user_01.id}"

    expect(page).to have_content("Display Name: not set")

    click_link "Edit Display Name"
    fill_in "Display Name", with: "test name"
    click_button "Submit"

    expect(page).to have_content("Display Name: test name")
  end

  pending "users can remove the display name from their account"
  pending "users can upload an avatar for their account"
  pending "users can remove an avatar from their account"
  pending "users can change their password"

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
