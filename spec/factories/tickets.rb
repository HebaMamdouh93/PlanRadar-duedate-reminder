FactoryBot.define do
  factory :ticket do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    due_date { rand(0..7).days.from_now.to_date }
    assigned_user { association :user }
    status { Ticket.statuses[:open] }
    progress { 0 }
  end
end
