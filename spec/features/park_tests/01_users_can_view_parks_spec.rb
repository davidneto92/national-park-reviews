require "rails_helper"

feature "users can view park(s)" do
  scenario "signed in users can view index page that lists all parks" do
    user = FactoryGirl.create(:user)

    visit "/"
    click_link "Sign in"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_on "Log in"

    park_01 = FactoryGirl.create(:park, main_image: "https://cityofwinterpark.org/wp-content/uploads/2014/05/DinkyDockPark_Field.jpg")
    park_02 = FactoryGirl.create(:park, main_image: "http://weknowyourdreams.com/images/park/park-08.jpg")

    expect(page).to have_content(park_01.name)
    expect(page).to have_content(park_02.name)
    expect(page).to have_content(park_01.state)
    expect(page).to have_content(park_02.state)
    expect(page).to have_css("img[src*='https://cityofwinterpark.org/wp-content/uploads/2014/05/DinkyDockPark_Field.jpg']")
    expect(page).to have_css("http://weknowyourdreams.com/images/park/park-08.jpg")
  end

  pending "non-signed in users can view index page that lists all parks"

  pending "all users can view a show page for a single park"

  pending "park index is paginated" # to be added
end
