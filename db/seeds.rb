require 'faker'

puts "Seeding users and tickets..."

user_count = 100
tickets_per_user = 5

user_count.times do
  user = FactoryBot.create(:user)
  tickets_per_user.times do
    FactoryBot.create(:ticket, assigned_user: user)
  end
end

puts "✅ Done seeding #{user_count} users and #{user_count * tickets_per_user} tickets."
