User.create!(username:  "Example User",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true)

User.create!(username:  "chris",
             email: "chris.rhoton@gmail.com",
             password:              "bewd2014",
             password_confirmation: "bewd2014",
             admin: true)

99.times do |n|
  username  = Faker::Internet.user_name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(username:              username,
               email:                 email,
               password:              password,
               password_confirmation: password)
end