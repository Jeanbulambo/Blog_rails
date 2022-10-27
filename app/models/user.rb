class User < ApplicationRecord
  has_many :posts
  has_many :likes
  has_many :comments

  def most_recent_post
    post.order(created_at: DESC).limit(3)
  end
end
