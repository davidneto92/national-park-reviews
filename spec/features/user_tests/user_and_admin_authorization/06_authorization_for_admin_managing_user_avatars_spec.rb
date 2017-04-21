require "rails_helper"

feature "admin can manage a user's account avatar" do
  scenario "admin can upload a user avatar for a user" do
    user_01 = FactoryGirl.create(:user)
    user_02 = FactoryGirl.create(:user, role: "admin")
    login_as(user_02)
    visit "/users/#{user_01.id}"

    click_link("Edit Display Name and Avatar")
    attach_file("User Avatar", "#{Rails.root}/spec/support/test_avatar_acceptable.jpg")
    click_button("Submit")

    expect(page).to have_content("Account details updated.")
    expect(page).to_not have_css("img[src*='default_avatar.jpg']")
    expect(page).to have_css("img[src*='test_avatar_acceptable.jpg']")
  end

  scenario "admin can remove a user's avatar to be replaced by the default avatar" do
    user_01 = FactoryGirl.create(:user, avatar: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/test_avatar_acceptable.jpg'))))
    user_02 = FactoryGirl.create(:user, role: "admin")
    login_as(user_02)
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
