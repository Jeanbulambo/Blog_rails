require 'rails_helper'

RSpec.describe User, type: :model do
  user = User.create(name: 'Tom', photo: 'http://Instagram.com', bio: 'used to test user')

  describe 'Tests for User model validations' do
    it 'is not valid' do
      expect(user).to_not be_valid
    end

    it 'is valid ' do
      user.posts_counter = 1
      expect(user).to be_valid
    end

    it 'is not valid without a name' do
      user.name = nil
      expect(user).to_not be_valid
    end
  end
end
