class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  after_save :update_post_count
  after_destroy :update_post_count

  def initialize(attributes = {})
    super
    self.comments_counter ||= 0
    self.likes_counter ||= 0
  end

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end

  private

  def update_post_count
    author.update(post_count: author.posts.count)
  end
end
