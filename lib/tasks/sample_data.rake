namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    User.create!(name: "Caleb Wang",
                 email: "caleb@example.org",
                 password: "foobar",
                 password_confirmation: "foobar",
                 admin: true)
    6.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
    
    users = User.all(limit: 6)
    50.times do
      title = "Hunger Game"
      description = Faker::Lorem.sentence(5)
      users.each { |user| user.events.create!(title: title, description: description) }
    end
  end
end