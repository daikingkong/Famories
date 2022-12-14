class JoinRequest < ApplicationRecord
  belongs_to :end_user
  belongs_to :group

  validates :end_user_id, presence: true
  validates :group_id, presence: true

end