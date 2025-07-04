require "rails_helper"

RSpec.describe DueDateRemindersMailer, type: :mailer do
   describe "#due_date_reminder" do
    let(:user) { create(:user, email: "user@example.com") }
    let(:ticket1) { create(:ticket, title: "Fix ceiling", assigned_user: user) }
    let(:ticket2) { create(:ticket, title: "Repair pipe", assigned_user: user) }

    let(:mail) { described_class.due_date_reminder(user, [ ticket1, ticket2 ]) }

    it "renders the headers" do
      expect(mail.to).to eq([ "user@example.com" ])
      expect(mail.subject).to eq("Reminder: You have 2 ticket(s) due soon")
    end

    it "renders the body with ticket titles" do
      expect(mail.body.encoded).to include("Fix ceiling")
      expect(mail.body.encoded).to include("Repair pipe")
    end

    it "delivers the email" do
      expect {
        described_class.due_date_reminder(user, [ ticket1 ]).deliver_now
      }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end
  end
end
