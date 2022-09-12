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


  # 登録や編集時に既存のタグと同名のモノは削除し、新しいタグのみ保存する
  def save_tag(sent_memory_tags)
    current_memory_tags = self.memory_tags.pluck(:name) unless self.memory_tags.nil?
    old_memory_tags = current_memory_tags - sent_memory_tags
    new_memory_tags = sent_memory_tags - current_memory_tags

    old_memory_tags.each do |old|
      self.memory_tags.delete MemoryTag.find_by(name: old)
    end

    new_memory_tags.each do |new|
      new_memory_tag = MemoryTag.find_or_create_by(name: new)
      self.memory_tags << new_memory_tag
    end
  end

  def self.search_for(content)
    Memory.where('title LIKE ?', '%'+content+'%')
  end

end
