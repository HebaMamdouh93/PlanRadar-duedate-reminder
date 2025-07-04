require 'rails_helper'

RSpec.describe EmailNotification, type: :service do
  describe "#send_email" do
    let(:user) { create(:user) }
    let(:tickets) { create_list(:ticket, 2, assigned_user: user) }

    it "sends an email via the mailer" do
      mail_double = double("MailMessage")

      expect(DueDateRemindersMailer)
        .to receive(:due_date_reminder)
        .with(user, tickets)
        .and_return(mail_double)

      expect(mail_double).to receive(:deliver_later)

      described_class.new(user: user, tickets: tickets).send_email
    end
  end
end
