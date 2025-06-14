require 'rails_helper'

RSpec.describe Ticket, type: :model do
  ##### Associations #####
  it { should belong_to(:assigned_user).class_name('User')  }

   ##### Enums #####
   it do
    should define_enum_for(:status)
      .with_values(open: 0, in_progress: 1, resolved: 2)
      .backed_by_column_of_type(:integer)
  end

  ##### Validations #####
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:status) }
  it { should validate_presence_of(:assigned_user_id) }

  it do
    should validate_numericality_of(:progress)
      .is_greater_than_or_equal_to(0)
      .is_less_than_or_equal_to(100)
  end

  ##### Custom Validation Tests #####
  describe "progress boundary values" do
    let(:user) { create(:user) }
    let(:ticket) { build(:ticket, assigned_user: user) }
    it "should allow a progress value of 0" do
      ticket.progress = 0
      expect(ticket).to be_valid
    end

    it "should allow a progress value of 100" do
      ticket.progress = 100
      expect(ticket).to be_valid
    end

    it "should allow a progress value of 45" do
      ticket.progress = 45
      expect(ticket).to be_valid
    end
    it "should not allow a progress value of -1" do
      ticket.progress = -1
      expect(ticket).not_to be_valid
    end

     it "should not allow a progress value of 150" do
      ticket.progress = 150
      expect(ticket).not_to be_valid
    end
  end
end
