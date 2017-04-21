require "rails_helper"

feature "admin accounts can edit park information" do
  scenario "admin are authorized to edit information any parks" do
    user_01 = FactoryGirl.create(:user)
    user_02 = FactoryGirl.create(:user, role: "admin")
    park_01 = FactoryGirl.create(:park, user_id: user_01.id, main_image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/mountains_01.jpg'))))
    login_as(user_02)

    visit "/parks/#{park_01.id}/edit"
    expect(page).to_not have_content("The page you were looking for doesn't exist.")

    fill_in "Park Name", with: "NEW Park name"
    select "Hawaii", from: "State"
    attach_file("Park Image", "#{Rails.root}/spec/support/upload_test_picture.jpg")
    click_button("Submit")

    expect(page).to have_content("NEW Park name")
    expect(page).to have_content("Location: Hawaii")
    expect(page).to have_css("img[src*='upload_test_picture.jpg']")
  end
end
