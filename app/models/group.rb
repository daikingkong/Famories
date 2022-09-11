class Group < ApplicationRecord
  has_many :group_users, dependent: :destroy
  has_many :join_requests, dependent: :destroy
  has_many :end_users, through: :group_users

  has_many :group_memories, dependent: :destroy

  validates :name, length: { minimum: 1, maximum: 20 }
  validates :introduction, length: {maximum: 50 }

  has_one_attached :group_image

  def get_group_image
    (group_image.attached?) ? group_image : 'no_image.jpg'
  end

  # 加入リクエストを送っているか判定
  def already_requested?(end_user)
    self.join_requests.exists?(end_user_id: end_user.id)
  end

end
