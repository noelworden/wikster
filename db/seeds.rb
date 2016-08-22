  # 3.times do
  #   User.create!(
  #     username: Faker::Internet.user_name,
  #     email: Faker::Internet.email,
  #     password: Faker::Internet.password(8)
  #     )
# end
# users = User.all

# admin = User.create!(
#   username: "admin",
#   email: "admin@wikster.com",
#   password: "password",
#   )

# me = User.create!(
#   username: "nworden",
#   email: "noelworden@gmail.com",
#   password: "password",
#   )

# member01 = User.create!(
#   username: "member01",
#   email: "member01@wikster.com",
#   password: "password",
#   )

# member02 = User.create!(
#   username: "member02",
#   email: "member02@wikster.com",
#   password: "password",
#   )

20.times do
  Wiki.create!(
    title: Faker::Hipster.sentence(5),
    body: Faker::Hipster.paragraph(3),
    private: false,
    user_id: rand(1..7)
    )
end
wikis = Wiki.all

p "Seeding complete"
p "#{User.count} users have been created"
p "#{Wiki.count} wikis have been created"