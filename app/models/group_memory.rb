class GroupMemory < ApplicationRecord
  belongs_to :end_user
  belongs_to :group

  validates :title, length: {minimum: 1, maximum: 30 }
  validates :memo, length: {maximum: 150 }

  # 部分テンプレートで使用するので命名はこのままにすること
  has_one_attached :memory_image

  def get_memory_image
    (memory_image.attached?) ? memory_image : 'no_image.jpg'
  end

end
