# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(email: "test_email_01@email.com", password: "password")
User.create(email: "test_email_02@email.com", password: "password")
User.create(email: "test_email_03@email.com", password: "password")
User.create(email: "test_email_04@email.com", password: "password", role: "admin")

for x in 0..15
  Park.create(name: "Park #{x + 1}", state: ["Massachusetts","Rhode Island","New Hampshire","Maine"].sample,
  user_id: (rand(4) + 1),
  main_image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/mountains_01.jpg'))))
end
