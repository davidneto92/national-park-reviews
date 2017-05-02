require "rails_helper"

feature "user can create account" do
  scenario "new user can click sign-up button to create account" do
    visit "/"
    click_link "Sign up"
    expect(page).to have_content "Sign up"
    expect(page).to have_field("Email")
    expect(page).to have_field("Password")
    expect(page).to have_field("Password confirmation")
    expect(page).to have_field("Display Name")
    expect(page).to have_button("Sign Up")
  end

  scenario "user provides required information to create account" do
    visit "/"
    click_link "Sign up"
    fill_in "Email", with: "jeff45@email.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    fill_in "Display Name", with: "Jeffery" # currently optional

    click_button "Sign Up"
    expect(page).to have_content("Account creation successful! Welcome!")
    expect(User.last.email).to eq "jeff45@email.com"
    expect(User.last.role).to eq "member"
    expect(User.last.display_name).to eq "Jeffery"
  end

  scenario "account not created when user does not provide required information" do
    visit "/"
    click_link "Sign up"

    click_button "Sign Up"
    expect(page).to_not have_content("Account creation successful! Welcome!")
    expect(page).to have_content("Please address the following errors to create an account:")
    expect(page).to have_content("Email can't be blank")
  end

  scenario "account not created when supplied passwords do not match" do
    visit "/"
    click_link "Sign up"

    fill_in "Email", with: "fake@email.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "notpassword"

    click_button "Sign Up"

    expect(page).to have_content("Password confirmation doesn't match Password")
  end

  scenario "account not created if invalid input for display name provided" do
    visit "/"
    click_link "Sign up"

    fill_in "Email", with: "fake@email.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    fill_in "Display Name", with: "bad display name"

    click_button "Sign Up"

    expect(page).to have_content("Display name Only allows letters and numbers")

    fill_in "Email", with: "fake@email.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    fill_in "Display Name", with: "i@@l"

    click_button "Sign Up"

    expect(page).to have_content("Display name is too short (minimum is 5 characters)")
    expect(page).to have_content("Display name Only allows letters and numbers")
  end
end
