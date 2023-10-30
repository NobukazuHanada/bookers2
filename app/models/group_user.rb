class GroupUser < ApplicationRecord
  belongs_to :group
  belongs_to :user

  validates :group, presence: true, uniqueness: { scope: :user }
  validates :user, presence: true

end
