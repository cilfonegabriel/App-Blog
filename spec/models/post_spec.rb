require 'rails_helper'

RSpec.describe Post, type: :model do
  user1 = User.new(name: 'Tom', photo: 'my_photo.com', bio: 'Bio message')
  subject { Post.new(author: user1, title: 'post title', text: 'posts text') }
  before { subject.save }

  it 'can not miss the title' do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it 'There can be no more than 250 characters in the title' do
    long_title = 'Nam quis nulla. Integer malesuada. In in enim a arcu imperdiet malesuada. Sed vel lectus. Donec odio urna, tempus molestie, porttitor ut, iaculis quis, sem. Phasellus rhoncus. Aenean id metus id velit ullamcorper pulvinar. Vestibulum fermentum tortor '
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
end