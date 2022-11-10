require 'rails_helper'
RSpec.describe Post, type: :feature do
  describe 'post_show page' do
    before(:each) do
      @user = User.create(name: 'Riziki', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Life is whata it is',
                          posts_counter: 0)
      @post = Post.create(title: 'Pair programming', text: 'Just now', comments_counter: 0, likes_counter: 1,
                          author_id: @user.id)
      Comment.create(author_id: @user, post: @post, text: 'Hey I agree with you')
      @users = User.all
      visit user_post_path(@users.ids, @post.id)
    end

    it 'I can see the author of a post.' do
      visit user_post_path(@user.id, @post.id)
      expect(page).to have_content('Riziki')
    end

    it 'I can see the title ' do
      expect(page).to have_content(@post.title)
    end

    it 'I can see the number of comments for a post' do
      expect(page).to have_content(@post.comments_counter)
    end

    it 'I can see the number of likes for a post' do
      expect(page).to have_content(@post.likes_counter)
    end

    it "I can see the user's first 4 posts" do
      expect(page).to have_content(@post.text.first(4))
    end

    it 'I can see the username of each one who commented.' do
      comments = @post.comments
      comments.each do |comment|
        expect(comment.author_id).to have_content(comment.user.name)
      end
    end
    it 'I can see the comment each commentor left.' do
      comments = @post.comments
      comments.each do |comment|
        expect(comment.text).to have_content(comment.text)
      end
    end
  end
end
