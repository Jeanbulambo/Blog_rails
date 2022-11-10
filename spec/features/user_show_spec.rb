require 'rails_helper'

RSpec.describe User, type: :feature do
  describe 'user_show page' do
    before(:each) do
      @user = User.create(name: 'Bulambo',
                          photo: 'https://images.pexels.com/photos/1043471/pexels-photo-1043471.jpeg?auto=compress&cs=tinysrgb&w=80',
                          bio: 'Rspec test', posts_counter: 3)
      @first_post = Post.create(author_id: @user.id, title: 'post_one', text: 'first_post', comments_counter: 0,
                                likes_counter: 0)
      @second_post = Post.create(author_id: @user.id, title: 'post_two', text: 'second_post', comments_counter: 0,
                                 likes_counter: 0)
      @third_post = Post.create(author_id: @user.id, title: 'post_three', text: 'third_post', comments_counter: 0,
                                likes_counter: 0)
      visit user_path(@user.id)
    end

    it 'should see the user\'s profile picture' do
      expect(page).to have_css("img[src*='#{@user.photo}']")
    end

    it "should see the user's name" do
      expect(page).to have_content(@user.name)
    end

    it 'should see the number of posts the user has written' do
      expect(page).to have_content(@user.posts_counter)
    end

    it 'should see the user\'s bio' do
      expect(page).to have_content(@user.bio)
    end

    it 'has recent three posts' do
      visit user_path(@user.id)
      expect(page).to have_content('first_post')
      expect(page).to have_content('second_post')
      expect(page).to have_content('third_post')
    end

    it 'redirects to user post show page' do
      visit user_posts_path(@user.id)
      expect(page).to have_current_path user_posts_path(@user.id)
    end
  end
end
