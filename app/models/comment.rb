class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post, class_name: 'Post'

  after_save :update_comment_counter
  after_destroy :update_comment_counter

  def update_comment_counter
    post.update(comments_counter: post.comments.count)
  end

  def as_json(options = {})
    super({ only: %i[text author_id post_id] }.merge(options))
  end
end
