User.create!(username:  "Example User",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: false,
             activated: true,
             activated_at: Time.zone.now)

User.create!(username:  "chris",
             email: "chris.rhoton@gmail.com",
             password:              "bewd2014",
             password_confirmation: "bewd2014",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

30.times do |n|
  username  = Faker::Internet.user_name + rand(100).to_s
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(username:              username,
               email:                 email,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end

users = User.order(:created_at).take(6)
50.times do
  title   = Faker::Lorem.words.join(" ")
  tagline = Faker::Lorem.words(5).join(" ")
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.glyphs.create!(content: content, 
                                          title: title, 
                                          tagline: tagline) }
end