class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :likes
  has_many :comments

  after_save :update_comment_counter

  def update_comment_counter
    post.increment!(:comment_counter)
  end
end
