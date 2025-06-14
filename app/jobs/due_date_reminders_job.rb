class DueDateRemindersJob < ApplicationJob
  queue_as :default

  def perform(*args)
    User.due_date_reminders_enabled.find_each do |user|
      Time.use_zone(user.time_zone) do
        time_now = Time.zone.now
        reminder_time = user.reminder_time.strftime("%H:%M")
        if time_now.strftime("%H:%M") == reminder_time
          due_date = time_now.to_date + user.reminder_interval.days
          tickets = user.tickets.where(due_date: due_date)
          NotificationService.new(user:, tickets:).send_reminder if tickets.present?
        end
      end
    end
  end
end
