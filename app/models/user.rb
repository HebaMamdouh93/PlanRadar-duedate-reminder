class User < ApplicationRecord
  ##### Associations #####
  has_many :tickets, foreign_key: :assigned_user_id
end
