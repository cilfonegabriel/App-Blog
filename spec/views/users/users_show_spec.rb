require 'rails_helper'

RSpec.describe 'User show page - ', type: :feature do
  before :each do
    @user1 = User.create(
      name: 'User 1',
      photo: 'https://unsplash.com/photos/Hekapoo',
      bio: 'User1 bio',
      posts_counter: 0
    )
    @post1 = Post.create(title: 'post 1', text: 'new post 1', comments_counter: 0, likes_counter: 0, author: @user1)
    @post2 = Post.create(title: 'post 2', text: 'new post 2', comments_counter: 0, likes_counter: 0, author: @user1)
    @post3 = Post.create(title: 'post 3', text: 'new post 3', comments_counter: 0, likes_counter: 0, author: @user1)
    @post4 = Post.create(title: 'post 4', text: 'new post 4', comments_counter: 0, likes_counter: 0, author: @user1)
    @post5 = Post.create(title: 'post 5', text: 'new post 5', comments_counter: 0, likes_counter: 0, author: @user1)
    @comment1 = Comment.create(author: @user1, post: @post1, text: 'my comments')
    visit user_path(@user1)
  end

  it 'I can see the user\'s profile picture' do
    expect(page).to have_css("img[src='#{@user1.photo}']")
  end

  it 'I can see the user\'s username.' do
    expect(page).to have_content(@user1.name)
  end

  it 'I can see the user\'s first 3 posts.' do
    expect(page).to have_content(@post3.text)
    expect(page).to have_content(@post4.text)
    expect(page).to have_content(@post5.text)
  end

  it 'I can see the number of posts the user has written.' do
    expect(page).to have_content("Number of posts: #{@user1.posts_counter}")
  end

  it 'I can see the user\'s bio.' do
    expect(page).to have_content(@user1.bio)
  end

  it 'I can see a button that lets me view all of a user\'s posts.' do
    expect(page).to have_content('See all posts')
  end

  it 'When I click a users post, it redirects me to that posts show page.' do
    click_link @post3.text
    expect(page).to have_current_path(user_post_path(@user1, @post3))
  end

  it "When I click to see all posts, it redirects me to the user's post's index page." do
    click_link 'See all posts'
    expect(page).to have_current_path(user_posts_path(@user1))
  end
end