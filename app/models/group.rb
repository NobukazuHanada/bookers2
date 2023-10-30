class Group < ApplicationRecord
  has_one_attached :image

  has_many :group_users
  has_many :users, through: :group_users

  validates :name, presence: true, uniqueness: true
  validates :owner, presence: true

  has_one :owner, class_name: "GroupUser"
  has_one :owner_user, through: :owner, source: :user

  def get_image
    (image.attached?) ? image : 'no_image.jpg'
  end

  def is_join(user)
    users.exists?(id: user.id)
  end

end
