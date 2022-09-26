class MemoryTag < ApplicationRecord
  has_many :memory_search_tags, dependent: :destroy, foreign_key: 'memory_tag_id'
  has_many :memories, through: :memory_search_tags

  validates :name, presence: true

end
