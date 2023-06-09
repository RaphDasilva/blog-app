require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'validations' do
    author = User.create(name: 'Chris',
                         photo: 'https://i0.wp.com/imgs.hipertextual.com/wp-content/uploads/2022/10/Andor_Luthen-Rael.png',
                         bio: 'Software Engineer', post_count: 3)
    post = Post.create(author_id: author.id, title: 'Post', body: 'Hello world!', likes_counter: 4, comments_counter: 2)
    subject { Comment.new(author_id: author.id, post_id: post.id, body: 'Comment') }

    before { subject.save }

    it 'author id should be a number' do
      subject.author_id = 'a'
      expect(subject).to_not be_valid
    end

    it 'post id should be a number' do
      subject.post_id = 'b'
      expect(subject).to_not be_valid
    end

    it 'increments comments_counter' do
      expect(post.comments_counter).to_not eq(6)
      expect(post.comments_counter).to eq(2)
    end
  end
end
