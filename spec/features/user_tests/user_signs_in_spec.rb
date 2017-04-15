require "rails_helper"

feature "registered users can sign in" do
  scenario 'an nonexistant email and password is supplied' do
    current_user = FactoryGirl.create(:user)
    visit "/"
    click_link "Sign in"

    fill_in "Email", with: current_user.email
    fill_in "Password", with: current_user.password
    click_on "Log in"

    expect(page).to have_content("Log in successful.")
    expect(page).to have_link('Sign out')
  end

  scenario 'an existing email with the wrong password is denied access' do
    visit "/"
    click_link "Sign in"

    fill_in "Email", with: "not_registered23@gmail.com"
    fill_in "Password", with: "easypassword"
    click_on "Log in"

    expect(page).to_not have_content("Log in successful.")
    expect(page).to_not have_content('Sign out')
    expect(page).to have_content('Invalid Email or password.')
  end

  scenario 'an authenticated user cannot re-sign in' do
    logged_in_user = FactoryGirl.create(:user)
    visit "/"
    click_link "Sign in"

    fill_in "Email", with: logged_in_user.email
    fill_in "Password", with: logged_in_user.password
    click_on "Log in"

    expect(page).to have_content('Sign out')
    expect(page).to_not have_content('Sign in')

    visit new_user_session_path

    expect(page).to have_content('You are already signed in.')
  end
end
