require 'rails_helper'

RSpec.describe DueDateRemindersJob, type: :job do
  describe "#perform" do
    let(:time_now) { Time.zone.parse("2025-06-14 09:00") }
    let(:user) do
      create(:user,
        due_date_reminders_enabled: true,
        time_zone: "Cairo",
        reminder_time: time_now.in_time_zone("Cairo").strftime("%H:%M"),
        reminder_interval: 0
      )
    end

    let!(:matching_ticket) do
      create(:ticket, assigned_user: user, due_date: time_now.in_time_zone("Cairo").to_date)
    end

    before do
      allow(Time).to receive(:now).and_return(time_now)
    end

    it "calls NotificationService for users with due tickets at reminder time" do
      # Set everything in user's time zone
      Time.use_zone(user.time_zone) do
        # Freeze time exactly at the user's reminder time in their zone
        now = Time.zone.parse(user.reminder_time.strftime("%H:%M"))

        travel_to(now) do
          expect(NotificationService).to receive(:new)
            .with(user: user, tickets: [ matching_ticket ])
            .and_call_original

          described_class.perform_now
        end
      end
    end


    it "does not call NotificationService if no tickets match" do
      matching_ticket.update!(due_date: 5.days.from_now)

      expect(NotificationService).not_to receive(:new)

      described_class.perform_now
    end

    it "does not call NotificationService if user has reminders disabled" do
      user.update!(due_date_reminders_enabled: false)

      expect(NotificationService).not_to receive(:new)

      described_class.perform_now
    end
  end
end
