require "rails_helper"

feature "logged in users can sign out" do
  scenario 'able to sign out when signed in' do
    signed_in_user = FactoryGirl.create(:user, email: "signed_in_user@email.com")
    visit "/"
    click_link "Sign in"

    fill_in "Email", with: signed_in_user.email
    fill_in "Password", with: signed_in_user.password
    click_on "Log in"

    expect(page).to have_content("Log in successful.")
    # expect(current_user).to eq(signed_in_user)
    # binding.pry
    click_link "Sign out"

    expect(page).to have_content("Log out successful.")
    # expect(current_user).to be(nil)
  end

  scenario "user must be signed in to sign out" do
    visit "/"
    expect(page).to_not have_link("Sign out")
  end
end
