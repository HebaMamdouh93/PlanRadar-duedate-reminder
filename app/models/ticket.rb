class Ticket < ApplicationRecord
  ##### Associations #####
  belongs_to :assigned_user, class_name: "User"

  ##### Enums #####
  enum :status, { open: 0, in_progress: 1, resolved: 2 }

  ##### Validations #####
  validates :title, :description, :status, :assigned_user_id, presence: true
  validates :progress, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
end
