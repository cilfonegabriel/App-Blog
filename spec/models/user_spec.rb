require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'John', photo: 'my_photo.com', bio: 'Some bio message') }

  before { subject.save }

  it 'name should be present' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'post_counter should be positive' do
    subject.posts_counter = -1
    expect(subject).to_not be_valid
  end
end