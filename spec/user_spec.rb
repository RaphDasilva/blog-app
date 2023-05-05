require 'rails_helper'

RSpec.describe User, type: :model do
    subject { User.new(name: 'Raph', post_count: 1) } 

    before {subject.save} 

    it 'name should be blank' do
        subject.name = nil
        expect(subject).to_not be_valid  
    end

    it 'name should not be blank' do
      subject.name = 'Raph'
      expect(subject).to be_valid 
    end
    
    it 'Posts count must be an integer greater than or equal to zero' do
      subject.post_count = 2
      expect(subject).to be_valid  
    end

    it 'Posts count must be an integer greater than or equal to zero' do
        subject.post_count = -1
        expect(subject).to_not be_valid  
      end
    
      describe '#recent_posts' do
        before do
          5.times do |post|
            Post.create(author_id: subject.id, title: "Post  #{post}", body: "Text #{post}", comments_counter: 2,likes_counter: 6)
          end
        end
    
        it 'should return recent posts' do
          expect(subject.recent_posts).to eq(subject.posts.order(created_at: :desc).limit(3))
        end
    
        it 'should return only 3 posts' do
          expect(subject.recent_posts.count).to eq(3)
        end
      end
  end