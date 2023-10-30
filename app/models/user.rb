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
  has_many :view_histories
  has_many :group_users
  has_many :groups, through: :group_users

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

  def today_book_posts
    books.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
  end

  def yesterday_book_posts
    yesterday = Time.zone.now - 1.day
    books.where(created_at: yesterday.beginning_of_day..yesterday.end_of_day)
  end

  def this_week_book_posts
    today = Time.zone.now
    books.where(created_at: (today - 6.day).beginning_of_day..today.end_of_day)
  end

  def last_week_book_posts
    today = Time.zone.now
    books.where(created_at: (today - 13.day).beginning_of_day..(today - 7.day).end_of_day)
  end

  def ratio_today_yesterday_posts
    today_count = today_book_posts.count
    yesterday_count = yesterday_book_posts.count
    if yesterday_count == 0
      "-"
    else
      100 * today_count / yesterday_count
    end
  end

  def ratio_this_last_week_posts
    this_week_book_posts_count = this_week_book_posts.count
    last_week_book_posts_count = last_week_book_posts.count
    if last_week_book_posts_count == 0
      "-"
    else
      100 * this_week_book_posts_count / last_week_book_posts_count
    end
  end

  def per_day_posts_in_this_week
    posts = this_week_book_posts
    per_day_posts = [[], [], [], [], [], [], []]
    today = Time.zone.now
    posts.each do |post|
      d = Time.zone.at(today - post.created_at).day - 1
      per_day_posts[d].push(post)
    end
    per_day_posts
  end
end