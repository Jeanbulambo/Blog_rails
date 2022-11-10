require 'rails_helper'

RSpec.describe User, type: :feature do
  describe 'use_index page' do
    before(:each) do
      @user = User.create(name: 'Jean', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Rspec',
                          posts_counter: 0)
      @post = Post.create(title: 'Testing capybara', text: 'Just do it', comments_counter: 0, likes_counter: 1,
                          author_id: @user.id)
      @users = User.all
      visit users_path
    end

    it 'should print out username for all other users' do
      @users.each do |user|
        expect(page).to have_content(user.name)
      end
    end
    it 'should print out profile picture for each present user ' do
      @users.each do |user|
        expect(page).to have_css("img[src*='#{user.photo}']")
      end
    end
    it 'I can see the number of posts for each user' do
      @users.each do |user|
        expect(page).to have_content(user.posts_counter)
      end
    end
    it "should redirect to user's show page" do
      visit user_path(@users.ids)
      expect(page).to have_current_path(user_path(@users.ids))
    end
  end
end
