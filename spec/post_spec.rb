require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { User.create(name: 'Raph', photo: 'http://placekitten.com/g/200/300', bio: 'test user', post_count: 0) }
  subject { Post.new(author: user, title: 'Hello', body: 'This is my first post', comments_counter: 0, likes_counter: 0) } 

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without a title' do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  describe '#recent_comments' do
    context 'when post has 5 comments' do
      before do
        5.times { |i| Comment.create(post: subject, author: user, body: "comment #{i}") }
      end

      it 'returns 5 comments' do
        expect(subject.recent_comments.length).to eq(5)
      end
    end

    context 'when post has 7 comments' do
      before do
        7.times { |i| Comment.create(post: subject, author: user, body: "comment #{i}") }
      end

      it 'returns 5 comments' do
        expect(subject.recent_comments.length).to eq(5)
      end
    end

    context 'when post has 0 comments' do
      it 'returns 0 comments' do
        expect(subject.recent_comments.length).to eq(0)
      end
    end

    context 'when post has 3 comments' do
      before do
        3.times { |i| Comment.create(post: subject, author: user, body: "comment #{i}") }
      end

      it 'returns 3 comments' do
        expect(subject.recent_comments.length).to eq(3)
      end
    end
  end

  describe '#update_post_count' do
    let(:user_with_posts) { User.create(name: 'John', post_count: 0) }

    it 'updates the post count of the author' do
      expect { 
        Post.create(author: user_with_posts, title: 'Test', body: 'This is a test post', comments_counter: 0, likes_counter: 0)
      }.to change { user_with_posts.reload.post_count }.from(0).to(1)
    end
  end
end