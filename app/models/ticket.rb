class Ticket < ApplicationRecord
  include ActiveModel::Validations
  ##### Associations #####
  belongs_to :assigned_user, class_name: "User"

  ##### Enums #####
  enum :status, { open: 0, in_progress: 1, resolved: 2 }
end
