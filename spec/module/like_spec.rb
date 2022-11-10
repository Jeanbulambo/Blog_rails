require 'rails_helper'

RSpec.describe Like, type: :model do
  user = User.create(name: 'news 1', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Testing.',
                     posts_counter: 0)
  post = Post.create(title: 'News 2', text: 'We are just testing', comments_counter: 1, likes_counter: 0,
                     author_id: 1)
  like = Like.new(post_id: post.id, author_id: user.id)

  describe 'Tests for Like model validations' do
    it 'like should be valid' do
      expect(like).to be_valid
    end

    it 'Increases the likes_counter' do
      counter = Post.find(post.id).likes_counter
      like.updates_likes_counter
      expect(Post.find(post.id).likes_counter).to eq(counter + 1)
    end
  end
end
