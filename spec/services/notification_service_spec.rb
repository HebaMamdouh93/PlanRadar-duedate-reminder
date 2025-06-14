require 'rails_helper'

RSpec.describe NotificationService, type: :service do
  describe "#send_reminder" do
    let(:user) { create(:user) }
    let(:tickets) { create_list(:ticket, 2, assigned_user: user) }

    it "delegates to EmailNotification with correct arguments" do
      email_service = instance_double(EmailNotification)

      expect(EmailNotification).to receive(:new)
        .with(user: user, tickets: tickets)
        .and_return(email_service)

      expect(email_service).to receive(:send_email)

      described_class.new(user: user, tickets: tickets).send_reminder
    end
  end
end
