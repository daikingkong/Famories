class EndUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :group_users, dependent: :destroy
  has_many :join_requests, dependent: :destroy
  has_many :groups, through: :group_users
  has_many :group_memories, dependent: :destroy
  has_many :memories, dependent: :destroy
  has_many :memories, dependent: :destroy
  has_many :memory_favorites, dependent: :destroy
  has_many :memory_comments, dependent: :destroy


  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, uniqueness: true
  validates :encrypted_password, presence: true

  default_scope -> { order(created_at: :desc) }

  has_one_attached :profile_image

  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end

  def self.guest
    find_or_create_by!(name: 'guestuser' ,email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "guestuser"
      user.email = "guest@example.com"
    end
  end

end
