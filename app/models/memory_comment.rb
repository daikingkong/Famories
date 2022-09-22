class MemoryComment < ApplicationRecord
  belongs_to :end_user
  belongs_to :memory

  validates :comment, presence: true, length: { maximum: 50 }

end
