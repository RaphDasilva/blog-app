require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) { User.create(name: 'Raph', photo: 'http://placekitten.com/g/200/300', bio: 'test user', post_count: 0) }
  let(:post) { Post.create(title: 'Title', body: 'Body', author: user, comments_counter: 0, likes_counter: 1) }
  let(:like) { Like.create(post:, author_id: user.id) }

  describe '#update_likes_counter' do
    it 'updates the likes counter of the post after creating a like' do
      expect(post.reload.likes_counter).to eq(1)
    end

    it 'updates the likes counter of the post after destroying a like' do
      like.destroy
      expect(post.reload.likes_counter).to eq(0)
    end
  end
end
