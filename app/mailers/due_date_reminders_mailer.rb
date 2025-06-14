class DueDateRemindersMailer < ApplicationMailer
  def due_date_reminder(user, tickets)
    @user = user
    @tickets = tickets

    mail(to: user.email, subject: "Reminder: You have #{tickets.size} ticket(s) due soon")
  end
end
