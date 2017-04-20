require "rails_helper"

feature "users can manage their account avatar" do
  scenario "users avatar will default to a predetermined image" do
    user_01 = FactoryGirl.create(:user)
    login_as(user_01)
    visit "/users/#{user_01.id}"

    expect(page).to have_css("img[src*='default_avatar.jpg']")
  end

  scenario "users can upload a user avatar if it meets the file requirements" do
    user_01 = FactoryGirl.create(:user)
    login_as(user_01)
    visit "/users/#{user_01.id}"

    click_link("Edit Display Name and Avatar")
    attach_file("User Avatar", "#{Rails.root}/spec/support/test_avatar_acceptable.jpg")
    click_button("Submit")

    expect(page).to have_content("Account details updated.")
    expect(page).to_not have_css("img[src*='default_avatar.jpg']")
    expect(page).to have_css("img[src*='test_avatar_acceptable.jpg']")
  end

  scenario "upload fails if the picture does not meet the file requirements" do
    user_01 = FactoryGirl.create(:user)
    login_as(user_01)
    visit "/users/#{user_01.id}"

    click_link("Edit Display Name and Avatar")
    attach_file("User Avatar", "#{Rails.root}/spec/support/test_avatar_too_big.png")
    click_button("Submit")

    expect(page).to_not have_content("Account details updated.")
    expect(page).to_not have_css("img[src*='test_avatar_too_big.png']")
    expect(page).to have_content("That image is too large. Avatars must be smaller than 500kb.")
  end

  scenario "users can remove their uploaded picture to be replaced by the default avatar" do
    user_01 = FactoryGirl.create(:user, avatar: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/test_avatar_acceptable.jpg'))))
    login_as(user_01)
    visit "/users/#{user_01.id}"

    expect(page).to have_css("img[src*='test_avatar_acceptable.jpg']")

    click_link("Edit Display Name and Avatar")
    check("Remove avatar?")
    click_button("Submit")

    expect(page).to_not have_css("img[src*='test_avatar_acceptable.jpg']")
    expect(page).to have_css("img[src*='default_avatar.jpg']")
    expect(page).to have_content("Account details updated.")

  end
end
