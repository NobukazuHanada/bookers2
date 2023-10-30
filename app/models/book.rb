class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites
  has_many :book_comments
  has_many :view_histories
  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200 }

  validates :rating, numericality: { greater_than_or_equal_to: 0,
                                     less_than_or_equal_to: 5 }

  def favorite_by(user)
    favorites.exists?(user_id: user.id)
  end
end
