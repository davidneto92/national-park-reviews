require "rails_helper"

# these tests may be removed and added to a separate branch for voting
feature "signed in users can vote on park" do
  scenario "signed in user can vote up on park" do
    user_01 = FactoryGirl.create(:user)
    user_02 = FactoryGirl.create(:user)
    park_01 = FactoryGirl.create(:park, user_id: user_01.id, main_image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/mountains_01.jpg'))))

    login_as(user_02)
    visit "/parks/#{park_01.id}"

    expect(Park.last.calculate_score).to eq(0)
    expect(page).to have_link("⇑")
    expect(page).to have_content("Your rating")
    expect(page).to have_link("⇓")

    all("a", :text => "⇑")[0].click

    expect(Park.last.calculate_score).to eq(1)
    expect(Park.last.calculate_score).to_not eq(0)
  end

  scenario "signed in user can vote down on park" do
    user_01 = FactoryGirl.create(:user)
    user_02 = FactoryGirl.create(:user)
    park_01 = FactoryGirl.create(:park, user_id: user_01.id, main_image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/mountains_01.jpg'))))

    login_as(user_02)
    visit "/parks/#{park_01.id}"

    expect(Park.last.calculate_score).to eq(0)

    all("a", :text => "⇓")[0].click

    expect(Park.last.calculate_score).to eq(-1)
    expect(Park.last.calculate_score).to_not eq(0)
  end

  scenario "selecting upvote a second time will reset your vote to zero" do
    user_01 = FactoryGirl.create(:user)
    user_02 = FactoryGirl.create(:user)
    park_01 = FactoryGirl.create(:park, user_id: user_01.id, main_image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/mountains_01.jpg'))))

    login_as(user_02)
    visit "/parks/#{park_01.id}"

    all("a", :text => "⇑")[0].click
    expect(Park.last.calculate_score).to eq(1)

    all("a", :text => "⇑")[0].click
    expect(Park.last.calculate_score).to eq(0)
  end

  scenario "selecting downvote a second time will reset your vote to zero" do
    user_01 = FactoryGirl.create(:user)
    user_02 = FactoryGirl.create(:user)
    park_01 = FactoryGirl.create(:park, user_id: user_01.id, main_image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/mountains_01.jpg'))))

    login_as(user_02)
    visit "/parks/#{park_01.id}"

    all("a", :text => "⇓")[0].click
    expect(Park.last.calculate_score).to eq(-1)

    all("a", :text => "⇓")[0].click
    expect(Park.last.calculate_score).to eq(0)
  end

  scenario "selecting upvote after selecting downvote will change score" do
    user_01 = FactoryGirl.create(:user)
    user_02 = FactoryGirl.create(:user)
    park_01 = FactoryGirl.create(:park, user_id: user_01.id, main_image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/mountains_01.jpg'))))

    login_as(user_02)
    visit "/parks/#{park_01.id}"

    all("a", :text => "⇑")[0].click
    expect(Park.last.calculate_score).to eq(1)

    all("a", :text => "⇓")[0].click
    expect(Park.last.calculate_score).to eq(-1)
  end

  scenario "selecting downvote after selecting upvote will change score" do
    user_01 = FactoryGirl.create(:user)
    user_02 = FactoryGirl.create(:user)
    park_01 = FactoryGirl.create(:park, user_id: user_01.id, main_image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/mountains_01.jpg'))))

    login_as(user_02)
    visit "/parks/#{park_01.id}"

    all("a", :text => "⇓")[0].click
    expect(Park.last.calculate_score).to eq(-1)

    all("a", :text => "⇑")[0].click
    expect(Park.last.calculate_score).to eq(1)
  end

  scenario "non-signed in user cannot vote on a park" do
    user = FactoryGirl.create(:user)
    park_01 = FactoryGirl.create(:park, user_id: user.id, main_image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/mountains_01.jpg'))))

    visit "/parks/#{park_01.id}"

    expect(page).to_not have_link("⇑")
    expect(page).to_not have_content("Your rating")
    expect(page).to_not have_link("⇓")
    # visit "/parks/#{park_01.id}/upvote", action: post
    # expect(page).to have_content("The page you were looking for doesn't exist.")
  end

end
