class EmailNotification
  def initialize(user:, tickets:)
    @user = user
    @tickets = tickets.to_a
  end

  def send_email
    DueDateRemindersMailer.due_date_reminder(@user, @tickets).deliver_later
  end
end
