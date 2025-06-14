class NotificationService
  def initialize(user:, tickets:)
    @user = user
    @tickets = tickets
  end

  def send_reminder
    EmailNotification.new(user: @user, tickets: @tickets).send_email
  end
end
