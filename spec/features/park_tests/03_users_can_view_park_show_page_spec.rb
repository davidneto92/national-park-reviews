require "rails_helper"

feature "users can view a park\'s show page" do
  scenario "show page displays park name, image, creator, and stats" do
    user = FactoryGirl.create(:user)
    park_01 = FactoryGirl.create(:park, user_id: user.id, year_founded: 1939, area_miles: 379,
      main_image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/mountains_01.jpg'))))
    state_name = Park::STATES.find { |state| state.include?(park_01.state) }[0]

    visit "/"
    first(:link, "#{park_01.name}").click

    expect(page).to have_content(park_01.name)
    expect(page).to have_content("#{state_name}")
    expect(page).to have_content("Year Founded: #{park_01.year_founded}")
    expect(page).to have_content("Area (miles2): #{park_01.area_miles}")
    expect(page).to have_css("img[src*='mountains_01.jpg']")
  end

  scenario "signed in users can see link to user that created the park" do
    user_01 = FactoryGirl.create(:user)
    user_02 = FactoryGirl.create(:user)
    park_01 = FactoryGirl.create(:park, user_id: user_01.id, year_founded: 1939, area_miles: 379,
      main_image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/mountains_01.jpg'))))

    login_as(user_02)
    visit "/parks/#{park_01.id}"
    expect(page).to have_content("Submitted By: #{user_01.display_name}")
    expect(page).to have_link("#{user_01.display_name}")
  end

  scenario "non-signed in users will not see park creator" do
    user_01 = FactoryGirl.create(:user, display_name: "Jenny45")
    park_01 = FactoryGirl.create(:park, user_id: user_01.id, year_founded: 1939, area_miles: 379,
      main_image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/mountains_01.jpg'))))

    visit "/parks/#{park_01.id}"

    expect(page).to have_content("Submitted By: #{user_01.display_name}")
    expect(page).to_not have_link("#{user_01.display_name}")
  end

end
