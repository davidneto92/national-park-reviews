# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(email: "test_email_01@email.com", password: "password", display_name: "ricky4020")
User.create(email: "test_email_02@email.com", password: "password", display_name: "patriots_lover")
User.create(email: "test_email_03@email.com", password: "password", display_name: "flower555")
User.create(email: "test_email_04@email.com", password: "password", display_name: "carManiac", role: "admin")
User.create(email: "test_email_05@email.com", password: "password", display_name: "car_maniac_4")
User.create(email: "test_email_06@email.com", password: "password", display_name: "songbird")


Park.create(
  name: "Arches National Park",
  nps_page: "https://www.nps.gov/arch/index.htm",

  state: "Utah",
  nearby_city: "Moab",

  user_id: (rand(6) + 1),
  year_founded: 1929,
  area_miles: 120,
  main_image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/seeds/park_01.jpg')))
)

Park.create(
  name: "Everglades National Park",
  nps_page: "https://www.nps.gov/ever/index.htm",

  state: "Florida",
  user_id: (rand(6) + 1),
  year_founded: 1947,
  area_miles: 2344,
  main_image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/seeds/park_02.jpg')))
)

Park.create(
  name: "Voyageurs National Park",
  nps_page: "https://www.nps.gov/voya/index.htm",

  state: "Minnesota",
  user_id: (rand(6) + 1),
  year_founded: 1975,
  area_miles: 341,
  main_image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/seeds/park_03.jpg')))
)

Park.create(
  name: "Yosemite National Park",
  nps_page: "https://www.nps.gov/yose/index.htm",

  state: "California",
  user_id: (rand(6) + 1),
  year_founded: 1890,
  area_miles: 1169,
  main_image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/seeds/park_04.jpg')))
)

Park.create(
  name: "Rocky Mountains National Park",
  nps_page: "https://www.nps.gov/romo/index.htm",

  state: "Colorado",
  user_id: (rand(6) + 1),
  year_founded: 1915,
  area_miles: 415,
  main_image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/seeds/park_05.jpg')))
)

Park.create(
  name: "Mammoth Cave National Park",
  nps_page: "https://www.nps.gov/maca/index.htm",

  state: "Kentucky",
  user_id: (rand(6) + 1),
  year_founded: 1941,
  main_image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/seeds/park_06.jpg')))
)

Park.create(
  name: "Glacier National Park",
  nps_page: "https://www.nps.gov/glac/index.htm",

  state: "Montana",
  user_id: (rand(6) + 1),
  main_image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/seeds/park_07.jpg')))
)

Park.create(
  name: "Virgin Islands National Park",
  nps_page: "https://www.nps.gov/viis/index.htm",

  state: "US Territories",
  user_id: (rand(6) + 1),
  year_founded: 1956,
  area_miles: 23,
  main_image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/seeds/park_08.jpg')))
)

Park.create(
  name: "Black Canyon of the Gunnison National Park",
  nps_page: "https://www.nps.gov/blca/index.htm",

  state: "Colorado",
  user_id: (rand(6) + 1),
  year_founded: 1999,
  main_image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/seeds/park_09.jpg')))
)


Review.create(
  title: "A great time on the plateaus of Utah!",
  body: "The most amazing sights!! This place is a treasure. We planned on staying a few hours, but ended up staying the whole day. It is indescribable.",
  user_id: (rand(6) + 1),
  park_id: (Park.where(name: "Arches National Park")[0].id),
  visit_date: Date.new(2014,5,29)
)

Review.create(
  title: "Finally got to see these arches",
  body: "What an incredible park, I really can't believe it took me this long to visit. So many breathtaking sights all around the park.",
  user_id: (rand(6) + 1),
  park_id: (Park.where(name: "Arches National Park")[0].id),
  visit_date: Date.new(2015,6,4)
)

Review.create(
  title: "Mountains and views galore",
  body: "Beautiful, steep, narrow road going through some of the most gorgeous mountains. We have often seen wildlife driving this road but sometimes you just can't stop.",
  user_id: (rand(6) + 1),
  park_id: (Park.where(name: "Rocky Mountains National Park")[0].id),
  visit_date: Date.new(2017,3,18)
)

Review.create(
  title: "Tons of gators in this great park.",
  body: "The wildlife in the mangroves of the Everglades is remarkable. Just walking along a boardwalk we saw birds like anhingas and herons, and many alligators sunbathing.",
  user_id: (rand(6) + 1),
  park_id: (Park.where(name: "Everglades National Park")[0].id),
  visit_date: Date.new(2017,3,12)
)

Review.create(
  title: "Great day trip from Louisville",
  body: "The tour had about 500 steps but the first 280 were down, we enjoyed the tour but expected more formations which finally came at the end of the two hour tour Passageway can be very narrow and with low overheads at times. Open toe shoes should be avoided as one woman on our tour found out",
  user_id: (rand(6) + 1),
  park_id: (Park.where(name: "Mammoth Cave National Park")[0].id),
  visit_date: Date.new(2012,7,16)
)
