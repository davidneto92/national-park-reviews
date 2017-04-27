require "rails_helper"

feature "signed in users can vote on a review" do

  scenario "signed in user can upvote a review" do
    user_01 = FactoryGirl.create(:user)
    user_02 = FactoryGirl.create(:user)
    park_01 = FactoryGirl.create(:park, user_id: user_01.id, main_image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/mountains_01.jpg'))))
    review_01 = FactoryGirl.create(:review, user_id: user_01.id, park_id: park_01.id)

    login_as(user_02)
    visit "/parks/#{park_01.id}"

    expect(review_01.calculate_score).to eq(0)
    expect(page).to have_link("⇑")
    expect(page).to have_content("Review rating")
    expect(page).to have_link("⇓")

    all("a", :text => "⇑")[1].click

    expect(Review.last.calculate_score).to eq(1)
    expect(Review.last.calculate_score).to_not eq(0)
  end

  scenario "signed in user can downvote a revew" do
    user_01 = FactoryGirl.create(:user)
    user_02 = FactoryGirl.create(:user)
    park_01 = FactoryGirl.create(:park, user_id: user_01.id, main_image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/mountains_01.jpg'))))
    review_01 = FactoryGirl.create(:review, user_id: user_01.id, park_id: park_01.id)

    login_as(user_02)
    visit "/parks/#{park_01.id}"

    expect(Review.last.calculate_score).to eq(0)

    all("a", :text => "⇓")[1].click

    expect(Review.last.calculate_score).to eq(-1)
    expect(Review.last.calculate_score).to_not eq(0)
  end

  scenario "selecting upvote a second time will reset your vote to zero" do
    user_01 = FactoryGirl.create(:user)
    user_02 = FactoryGirl.create(:user)
    park_01 = FactoryGirl.create(:park, user_id: user_01.id, main_image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/mountains_01.jpg'))))
    review_01 = FactoryGirl.create(:review, user_id: user_01.id, park_id: park_01.id)

    login_as(user_02)
    visit "/parks/#{park_01.id}"

    all("a", :text => "⇑")[1].click
    expect(Review.last.calculate_score).to eq(1)

    all("a", :text => "⇑")[1].click
    expect(Review.last.calculate_score).to eq(0)
  end

  scenario "selecting downvote a second time will reset your vote to zero" do
    user_01 = FactoryGirl.create(:user)
    user_02 = FactoryGirl.create(:user)
    park_01 = FactoryGirl.create(:park, user_id: user_01.id, main_image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/mountains_01.jpg'))))
    review_01 = FactoryGirl.create(:review, user_id: user_01.id, park_id: park_01.id)

    login_as(user_02)
    visit "/parks/#{park_01.id}"

    all("a", :text => "⇓")[1].click
    expect(Review.last.calculate_score).to eq(-1)

    all("a", :text => "⇓")[1].click
    expect(Review.last.calculate_score).to eq(0)
  end

  scenario "selecting upvote after selecting downvote will change score" do
    user_01 = FactoryGirl.create(:user)
    user_02 = FactoryGirl.create(:user)
    park_01 = FactoryGirl.create(:park, user_id: user_01.id, main_image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/mountains_01.jpg'))))
    review_01 = FactoryGirl.create(:review, user_id: user_01.id, park_id: park_01.id)

    login_as(user_02)
    visit "/parks/#{park_01.id}"

    all("a", :text => "⇓")[1].click
    expect(Review.last.calculate_score).to eq(-1)

    all("a", :text => "⇑")[1].click
    expect(Review.last.calculate_score).to eq(1)
  end

  scenario "selecting downvote after selecting upvote will change score" do
    user_01 = FactoryGirl.create(:user)
    user_02 = FactoryGirl.create(:user)
    park_01 = FactoryGirl.create(:park, user_id: user_01.id, main_image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/mountains_01.jpg'))))
    review_01 = FactoryGirl.create(:review, user_id: user_01.id, park_id: park_01.id)

    login_as(user_02)
    visit "/parks/#{park_01.id}"

    all("a", :text => "⇑")[1].click
    expect(Review.last.calculate_score).to eq(1)

    all("a", :text => "⇓")[1].click
    expect(Review.last.calculate_score).to eq(-1)
  end

  scenario "non-signed in user cannot vote on a review" do
    user_01 = FactoryGirl.create(:user)
    park_01 = FactoryGirl.create(:park, user_id: user_01.id, main_image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/mountains_01.jpg'))))
    review_01 = FactoryGirl.create(:review, user_id: user_01.id, park_id: park_01.id)

    visit "/parks/#{park_01.id}"

    expect(page).to have_link("⇑")
    expect(page).to have_content("Review rating")
    expect(page).to have_link("⇓")
  end

end
