require 'faker'

puts "Seeding users and tickets..."

user_count = 100
tickets_per_user = 5

user_count.times do
  # user = User.create!(
  #   name: Faker::Name.name,
  #   email: Faker::Internet.unique.email,
  #   due_date_reminders_enabled: [true, false].sample,
  #   reminder_interval: rand(0..3),
  #   reminder_time: Time.zone.parse("#{rand(8..18)}:00"),
  #   time_zone: ActiveSupport::TimeZone.all.sample.name
  # )
  user = FactoryBot.create(:user)

  tickets_per_user.times do
    # Ticket.create!(
    #   title: Faker::Lorem.sentence,
    #   description: Faker::Lorem.paragraph,
    #   due_date: rand(1..7).days.from_now.to_date,
    #   assignee: user,
    #   status: :open
    # )
    FactoryBot.create(:ticket, assigned_user: user)
  end
end

puts "✅ Done seeding #{user_count} users and #{user_count * tickets_per_user} tickets."
