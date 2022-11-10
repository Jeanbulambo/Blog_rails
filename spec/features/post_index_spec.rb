require 'rails_helper'
RSpec.describe Post, type: :feature do
  describe 'post_index page' do
    before(:each) do
      @user = User.create(name: 'Riziki', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Life is whata it is',
                          posts_counter: 0)
      @post = Post.create(title: 'Pair programming', text: 'Just do it', comments_counter: 0, likes_counter: 1,
                          author_id: @user.id)
      Comment.create(author_id: @user, post: @post, text: 'Lets do this')
      @users = User.all
      visit user_posts_path(@users.ids)
    end

    it 'should print out user name.' do
      visit user_posts_path(@user.id)
      expect(page).to have_content('Riziki')
    end
    it "should print out profile's picture." do
      visit user_posts_path(@user.id)
      expect(page).to have_xpath("//img[contains(@src,'https://unsplash.com/photos/F_-0BxGuVvo')]")
    end
    it 'should print out the number of posts.' do
      visit user_posts_path(@user.id)
      expect(page).to have_content('Just do it')
    end
    it 'I can see a post title.' do
      expect(page).to have_content('Pair programming')
    end
    it "I can see some post's body." do
      expect(page).to have_content('Pair programming')
    end
    it 'I can see first comment' do
      expect(page).to have_content(@post.comments.first)
    end
    it 'I can see number of comments.' do
      expect(page).to have_content(@post.comments_counter)
    end
    it 'I can see likes.' do
      expect(page).to have_content(@post.likes_counter)
    end

    it 'should see a section for pagination if there are more posts than fit on the view.' do
      expect(page).to have_content('Pagination')
    end

    it 'When I click on a post, it redirects me to that posts show page.' do
      visit user_posts_path(@user.id)
      click_link('Pair programming')
      expect(page).to have_current_path(user_post_path(@user.id, @post.id))
    end
  end
end
