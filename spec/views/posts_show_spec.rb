require 'rails_helper'

RSpec.describe 'post_show', type: :feature do
  before :each do
    @user1 = User.create(
      name: 'User 1',
      photo: 'https://unsplash.com/photos/Hekapoo',
      bio: 'User1 bio',
      posts_counter: 0
    )
    @post1 = Post.create(title: 'post 1', text: 'new post 1', comments_counter: 0, likes_counter: 0, author: @user1)
    @comment1 = Comment.create(author: @user1, post: @post1, text: 'my comments')
    visit user_post_path(@user1, @post1)
  end

  it 'I can see the posts title' do
    expect(page).to have_content(@post1.title)
  end

  it 'I can see how many likes a post has' do
    @user1.posts.each do |post|
      expect(page).to have_content(post.likes_counter)
    end
  end 

  it 'I can see who wrote the post' do
    expect(page).to have_content(@post1.author.name)
  end

  it 'I can see how many comments it has.' do
    expect(page).to have_content(@post1.comments_counter)
  end

  it 'I can see how many likes it has' do
    expect(page).to have_content(@post1.likes_counter)
  end

  it 'I can see the post body.' do
    expect(page).to have_content(@post1.text)
  end

  it 'I can see the name of each commentor.' do
    expect(page).to have_content(@comment1.author.name)
  end

  it 'I can see the comment each commentor left.' do
    expect(page).to have_content("#{@comment1.author.name}: #{@comment1.text}")
  end
end