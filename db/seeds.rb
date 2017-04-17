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

Park.create(name: "Park 01", main_image: "default_park.jpg", state: "MA", user_id: 1)
Park.create(name: "Park 02", main_image: "default_park.jpg", state: "RI", user_id: 2)
Park.create(name: "Park 03", main_image: "default_park.jpg", state: "CT", user_id: 2)
Park.create(name: "Park 04", main_image: "default_park.jpg", state: "MA", user_id: 4)
