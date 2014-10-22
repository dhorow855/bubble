namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    User.create!(name: "Joe User",
                 email: "joe@example.com",
                 password: "foobar",
                 password_confirmation: "foobar",
                 admin: true)
    99.times do |n|
      name = Faker::Name.name
      email = "joe-#{n+1}@example.com"
      password = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
  end
end
    