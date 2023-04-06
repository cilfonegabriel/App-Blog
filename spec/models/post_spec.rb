require 'rails_helper'

RSpec.describe Post, type: :model do
  subject do
    Post.new(
      author: User.new(name: 'Tom', photo: 'my_photo.com', bio: 'Bio message'),
      title: 'post title',
      text: 'post text',
      comments_counter: 0,
      likes_counter: 0
    )
  end
  before { subject.save }

  it 'title should be present' do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it 'There can be no more than 250 characters in the title' do
    long_title = 'Now we will create it blocks for each behaviour were
    expecting in the Movies model. So remember to be as clear as possible
    when describe your tests because you need to be a good communicator and
    make yourself understandable not only with computers but also with people.'
    subject.title = long_title
    expect(subject).to_not be_valid
  end

  it 'comments_counter should be positive' do
    subject.comments_counter = -1
    expect(subject).to_not be_valid
  end

  it 'likes_counter should be positive' do
    subject.likes_counter = -1
    expect(subject).to_not be_valid
  end

  it 'shows at most 5 recent comments' do
    subject.comments = [
      Comment.new(post: subject, author: subject.author, text: 'Hi Tom!'),
      Comment.new(post: subject, author: subject.author, text: 'Hi Tom!'),
      Comment.new(post: subject, author: subject.author, text: 'Hi Tom!'),
      Comment.new(post: subject, author: subject.author, text: 'Hi Tom!'),
      Comment.new(post: subject, author: subject.author, text: 'Hi Tom!'),
      Comment.new(post: subject, author: subject.author, text: 'Hi Tom!')
    ]
    expect(subject.recent_comments.length).to eql(5)
  end
end
