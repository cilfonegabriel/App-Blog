require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'Tom', photo: 'my_photo.com', bio: 'Bio message', posts_counter: 0) }

  before { subject.save }

  it 'can not miss the name' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'post_counter should be positive' do
    subject.posts_counter = -1
    expect(subject).to_not be_valid
  end

  it 'shows at most 3 recent posts' do
    subject.posts = [
      Post.new(author: subject, title: 'Hello', text: 'This is my first post', comments_counter: 0, likes_counter: 0),
      Post.new(author: subject, title: 'Hello', text: 'This is my first post', comments_counter: 0, likes_counter: 0),
      Post.new(author: subject, title: 'Hello', text: 'This is my first post', comments_counter: 0, likes_counter: 0),
      Post.new(author: subject, title: 'Hello', text: 'This is my first post', comments_counter: 0, likes_counter: 0),
      Post.new(author: subject, title: 'Hello', text: 'This is my first post', comments_counter: 0, likes_counter: 0),
      Post.new(author: subject, title: 'Hello', text: 'This is my first post', comments_counter: 0, likes_counter: 0)
    ]
    expect(subject.recent_posts.length).to eql(3)
  end
end