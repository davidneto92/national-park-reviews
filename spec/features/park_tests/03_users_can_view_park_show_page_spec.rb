require "rails_helper"

feature "users can view a park\'s show page" do
  scenario "show page displays park name, image, creator, and stats" do
    user = FactoryGirl.create(:user)
    park_01 = FactoryGirl.create(:park, user_id: user.id, year_founded: 1939, area_miles: 379,
      main_image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/mountains_01.jpg'))))
    state_name = Park::STATES.find { |state| state.include?(park_01.state) }[0]

    visit "/"
    click_link(park_01.name)

    expect(page).to have_content(park_01.name)
    expect(page).to have_content("Location: #{state_name}")
    expect(page).to have_content("Year Founded: #{park_01.year_founded}")
    expect(page).to have_content("Area (sq. miles): #{park_01.area_miles}")
    expect(page).to have_css("img[src*='mountains_01.jpg']")
  end

  # pending "reviews for park listed on page"
    # probably want to test this with the other review tests
end
