require "rails_helper"

feature "ParkDescription scans the NPS.gov page for each park to update it's brief description" do
  scenario "method pulls the park homepage description from the park.nps_page to display on park show page" do
    user = FactoryGirl.create(:user)
    park_01 = FactoryGirl.create(:park,
      user_id: user.id,
      nps_page: "https://www.nps.gov/arch/index.htm",
      main_image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/mountains_01.jpg'))))

    ParkDescriptionJob.new(park_01).perform

    visit "/parks/#{park_01.id}"

    expect(page).to have_content("from NPS.gov")
    expect(page).to have_content("Visit Arches and discover a landscape of contrasting colors, landforms and textures unlike any other in the world. The park has over 2,000 natural stone arches, in addition to hundreds of soaring pinnacles, massive fins and giant balanced rocks. This red rock wonderland will amaze you with its formations, refresh you with its trails, and inspire you with its sunsets.")
  end

end
