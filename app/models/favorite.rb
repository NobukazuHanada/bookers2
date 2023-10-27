class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :book
  validates :user, uniqueness: { scope: :book }
end
