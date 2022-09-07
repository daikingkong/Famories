class MemoryTag < ApplicationRecord
  has_many :memory_search_tags, dependent: :destroy

  validates :name, presence: true, length: {maximum: 20 }
end
