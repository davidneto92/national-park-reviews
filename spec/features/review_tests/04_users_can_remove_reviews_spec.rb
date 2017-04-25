require "rails_helper"

feature "users can remove reviews of parks" do
  scenario "users can delete their reviews" do
    user_01 = FactoryGirl.create(:user)
    park_01 = FactoryGirl.create(:park, user_id: user_01.id, main_image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/mountains_01.jpg'))))
    review_01 = FactoryGirl.create(:review, user_id: user_01.id, park_id: park_01.id)
    review_02 = FactoryGirl.create(:review, user_id: user_01.id, park_id: park_01.id)

    login_as(user_01)
    visit "parks/#{park_01.id}"

    # selects first delete button, corresponds to review_02 due to auto sorting
    click_link("Delete Review", match: :first)

    expect(Review.all.include?(review_02)).to be false
  end

  scenario "users cannot delete other users' reviews" do
    user_01 = FactoryGirl.create(:user)
    user_02 = FactoryGirl.create(:user)
    park_01 = FactoryGirl.create(:park, user_id: user_01.id, main_image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/mountains_01.jpg'))))
    review_01 = FactoryGirl.create(:review, user_id: user_01.id, park_id: park_01.id)
    review_02 = FactoryGirl.create(:review, user_id: user_01.id, park_id: park_01.id)

    login_as(user_02)
    visit "parks/#{park_01.id}"
    expect(page).to_not have_link("Delete Review")

    delete :destroy, review: "/parks/#{park_01.id}/reviews/#{review_02.id}/"

    expect(page).to have_content("The page you were looking for doesn't exist.")
    expect(Review.all.include?(review_02)).to be true
  end

  scenario "admin can delete any reviews" do
    user_01 = FactoryGirl.create(:user)
    user_02 = FactoryGirl.create(:user, role: "admin")
    park_01 = FactoryGirl.create(:park, user_id: user_01.id, main_image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/mountains_01.jpg'))))
    review_01 = FactoryGirl.create(:review, user_id: user_01.id, park_id: park_01.id)
    review_02 = FactoryGirl.create(:review, user_id: user_01.id, park_id: park_01.id)

    login_as(user_02)
    visit "parks/#{park_01.id}"

    click_link("Delete Review", match: :first)

    expect(Review.all.include?(review_02)).to be false
  end
end
