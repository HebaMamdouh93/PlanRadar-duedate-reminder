FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.unique.email }
    due_date_reminders_enabled { [ true, false ].sample }
    reminder_interval { rand(0..3) }
    reminder_time { Time.zone.parse("#{rand(1..23)}:00") } # between 1 AM and 11 PM
    time_zone { ActiveSupport::TimeZone.all.sample.name }
  end
end
