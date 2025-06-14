class User < ApplicationRecord
  ##### Associations #####
  has_many :tickets, foreign_key: :assigned_user_id

  ##### Validations #####
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@[^@\s]+\z/ }

  validates :time_zone, presence: true, inclusion: { in: ActiveSupport::TimeZone.all.map { |tz| tz.name } }
  validates :reminder_time, :reminder_interval, presence: true, if: -> { due_date_reminders_enabled == true }
end
