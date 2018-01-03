@user = User.create(email: "test@test.com", password: "asdfasdf", password_confirmation: "asdfasdf", first_name: "Job", last_name: "Snow")

puts "1 user created"

100.times do |post|
  Post.create(date: Date.today, rationale: "#{post} rationale content", user: @user)
end

puts "100 Posts have been created"
