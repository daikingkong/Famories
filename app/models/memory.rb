class Memory < ApplicationRecord
  belongs_to :end_user
  has_many :memory_comments, dependent: :destroy
  has_many :memory_favorites, dependent: :destroy
  has_many :memory_search_tags, dependent: :destroy
  has_many :memory_tags, through: :memory_search_tags

  validates :title, length: {minimum: 1, maximum: 30 }
  validates :memo, length: {maximum: 150 }

  has_one_attached :memory_image

  def get_memory_image
    (memory_image.attached?) ? memory_image : 'no_image.jpg'
  end

  def memory_favorited_by?(end_user)
    memory_favorites.exists?(end_user_id: end_user.id)
  end

end
