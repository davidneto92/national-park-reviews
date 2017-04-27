require "rails_helper"

# these tests may be removed and added to a separate branch for voting
feature "signed in users can vote on review" do
  scenario "upvote button changes when upvote clicked" do
    user_01 = FactoryGirl.create(:user)
    user_02 = FactoryGirl.create(:user)
    park_01 = FactoryGirl.create(:park, user_id: user_01.id, main_image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/mountains_01.jpg'))))
    review_01 = FactoryGirl.create(:review, user_id: user_01.id, park_id: park_01.id)

    login_as(user_02)
    visit "/parks/#{park_01.id}"

    all("a", :text => "⇑")[1].click
    expect(page).to have_css(".upvote", text: "⇑" )
    # need to test the exact link
  end

  pending "downvote button changes when downvote clicked"
  pending "clicked upvote button returns to unclicked status"
  pending "clicked downvote button returns to unclicked status"
  pending "vote buttons are inactive if user not signed in"

end
