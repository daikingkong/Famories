class Memory < ApplicationRecord
  belongs_to :end_user
  has_many :memory_comments, dependent: :destroy
  has_many :memory_favorites, dependent: :destroy
  has_many :memory_search_tags, dependent: :destroy
  has_many :memory_tags, through: :memory_search_tags

  validates :title, length: {minimum: 1, maximum: 30 }
  validates :memo, length: {maximum: 400 }

  has_one_attached :memory_image

  def get_memory_image
    (memory_image.attached?) ? memory_image : 'no_image.jpg'
  end

  def memory_favorited_by?(end_user)
    memory_favorites.exists?(end_user_id: end_user.id)
  end


  # メモリーへのタグ追加時に同名タグを増やさないため、また、未入力にすることでタグを外すため
  def save_tag(sent_memory_tags)
    current_memory_tags = self.memory_tags.pluck(:name) unless self.memory_tags.nil?
    old_memory_tags = current_memory_tags - sent_memory_tags
    new_memory_tags = sent_memory_tags - current_memory_tags

    # 未入力タグ(古いタグ)は外す
    old_memory_tags.each do |old_tag|
      self.memory_tags.delete MemoryTag.find_by(name: old_tag)
    end

    # 入力タグ(新しいタグ)は追加
    # MemorySearchTagモデルのmemory_tag_idを重複させないため新しいレコードか判定する
    new_memory_tags.each do |new_tag|
      new_memory_tag = MemoryTag.find_or_initialize_by(name: new_tag)
      if new_memory_tag.new_record?
        new_memory_tag.save!
        self.memory_tags << new_memory_tag
      else
        self.memory_tags << new_memory_tag
      end
    end
  end


  def self.search_for(content)
    Memory.where('title LIKE ?', '%'+content+'%')
  end

end
