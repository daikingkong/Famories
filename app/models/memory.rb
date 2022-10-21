class Memory < ApplicationRecord
  belongs_to :end_user
  has_many :memory_comments, dependent: :destroy
  has_many :memory_favorites, dependent: :destroy
  has_many :memory_search_tags, dependent: :destroy
  has_many :memory_tags, through: :memory_search_tags

  validates :title, length: {minimum: 1, maximum: 30 }
  validates :memo, length: {maximum: 400 }

   scope :latest, -> {order(created_at: :desc)}
   scope :old, -> {order(created_at: :asc)}
   scope :memory_favorite_count, -> {order(memory_favorite: :desc)}

  has_one_attached :memory_image

  def get_memory_image
    (memory_image.attached?) ? memory_image : 'no_image.jpg'
  end

  def memory_favorited_by?(end_user)
    memory_favorites.exists?(end_user_id: end_user.id)
  end


  # メモリーへのタグ紐づけ時に同名タグを増やずに新しいタグは作成したい、また、未入力時はタグの紐づけを外したい
  def save_tag(sent_memory_tags)
    current_memory_tags = self.memory_tags.pluck(:name) unless self.memory_tags.nil?
    old_memory_tags = current_memory_tags - sent_memory_tags
    new_memory_tags = sent_memory_tags - current_memory_tags

    # もともと紐づいていたタグは未入力なら外したい、それによって該当するメモリーが無くなったタグはレコードから削除したい
    old_memory_tags.each do |old_tag|
      self.memory_tags.delete MemoryTag.find_by(name: old_tag)
      old_memory_tag = MemoryTag.where(name: old_tag)
      memory = MemorySearchTag.where(memory_tag_id: old_memory_tag.ids).pluck(:memory_id)
      if memory.count == 0
        MemoryTag.find_by(name: old_tag).destroy
      end
    end

    # 入力されたタグ名に新しいタグがあれば作成したい、もともと紐づいていたタグでも入力されていれば再びメモリーに紐づけたい
    # MemorySearchTagモデルのmemory_tag_idを重複させないため新しいレコードか判定する必要がある
    new_memory_tags.each do |new_tag|
      unless new_tag.blank?
        new_memory_tag = MemoryTag.find_or_initialize_by(name: new_tag)
        if new_memory_tag.new_record?
          new_memory_tag.save!
          self.memory_tags << new_memory_tag
        else
          self.memory_tags << new_memory_tag
        end
      end
    end
  end


  def self.search_for(content)
    Memory.where('title LIKE ?', '%'+content+'%')
  end

end
