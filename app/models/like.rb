class Like < ApplicationRecord
  belongs_to :Post
  belongs_to :author, class_name: 'User'

  after_save :update_like_counter

  def update_like_counter
    post.increment!(:like_counter)
  end
end
