require 'rails_helper'

RSpec.describe User, type: :model do
  ##### Associations #####
  it { should have_many(:tickets).with_foreign_key(:assigned_user_id) }

  ##### Validations #####
  it { should validate_presence_of(:name) }

  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }
  it { should allow_value('user@example.com').for(:email) }
  it { should_not allow_value('invalid_email').for(:email) }

  it { should validate_presence_of(:time_zone) }

  it "validates time_zone inclusion in ActiveSupport::TimeZone" do
    user = build(:user, time_zone: "Invalid/Zone")
    expect(user).to be_invalid
    expect(user.errors[:time_zone]).to include("is not included in the list")
  end

  context "when due_date_reminders_enabled is true" do
    subject { build(:user, due_date_reminders_enabled: true) }

    it { should validate_presence_of(:reminder_time) }
    it { should validate_presence_of(:reminder_interval) }
  end

  context "when due_date_reminders_enabled is false" do
    subject { build(:user, due_date_reminders_enabled: false) }

    it "does not require reminder_time or reminder_interval" do
      subject.reminder_time = nil
      subject.reminder_interval = nil
      expect(subject).to be_valid
    end
  end

  ##### Scopes #####
  describe ".due_date_reminders_enabled" do
    it "returns only users with due_date_reminders_enabled = true" do
      user1 = create(:user, due_date_reminders_enabled: true)
      user2 = create(:user, due_date_reminders_enabled: false)

      expect(User.due_date_reminders_enabled).to include(user1)
      expect(User.due_date_reminders_enabled).not_to include(user2)
    end
  end
end
