class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books
  has_many :favorites
  has_many :book_comments
  has_many :follower_relationship, class_name: "Relationship", foreign_key: "followed_id"
  has_many :followed_relationship, class_name: "Relationship", foreign_key: "follower_id"
  has_many :follower_users, through: :follower_relationship, source: :follower
  has_many :followed_users, through: :followed_relationship, source: :followed
  has_many :dm_sends, class_name: "Dm", foreign_key: "from_id"
  has_many :dm_receive, class_name: "Dm", foreign_key: "to_id"

  has_one_attached :profile_image

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }

  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end

  def is_follow(user)
    followed_users.exists?(user.id)
  end

  def is_mutual_follow(user)
    is_follow(user) && user.is_follow(self)
  end

end