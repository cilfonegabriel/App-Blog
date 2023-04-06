require 'rails_helper'

RSpec.describe Comment, type: :model do
  user = User.create(name: 'jinx', photo: 'link', bio: 'player', posts_counter: 0)
  post = Post.create(author: user, title: 'Vacation', text: 'Bluest beach on hawai!', comments_counter: 0,
                     likes_counter: 0)
  subject { Comment.new(text: 'test comment', author: user, post:) }

  before { subject.save }

  it 'comment correctly created' do
    expect(subject).to be_valid
  end

  it 'should increment comments counter for post' do
    prev_counter = subject.post.comments_counter
    subject.update_comment_counter
    expect(subject.post.comments_counter) == prev_counter + 1
  end
end