class EndUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :join_requests, dependent: :destroy
  has_many :group_users, dependent: :destroy
  has_many :group_memories, dependent: :destroy
  has_many :memories, dependent: :destroy
  has_many :memories, dependent: :destroy
  has_many :memory_favorites, dependent: :destroy
  has_many :group, through: :group_users

  validates :name, presence: true
  validates :email, presence: true

end
