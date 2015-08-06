require 'faker'

7.times do 
  user = User.new(
    name: Faker::Name.name,
    email: Faker::Internet.free_email,
    password: Faker::Lorem.characters(8)
    )
  user.skip_confirmation!
  user.save!
end

 user = User.new(
    name: 'Admin',
    email: 'admin@example.com',
    password: 'helloworld',
    role: 'admin')

  user.skip_confirmation!
  user.save!

users = User.all

13.times do
   Wiki.create!(
     user: users.sample,
     title:  Faker::Lorem.sentence,
     body: Faker::Lorem.paragraph
   )
 end
 
 puts "Seed finished"
 puts "#{User.count} users created"
 puts "#{Wiki.count} wikis created"
