class JoinRequest < ApplicationRecord
  belongs_to :end_user
  belongs_to :group

end