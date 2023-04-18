require 'rails_helper'

RSpec.describe 'post_index', type: :feature do
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
    visit user_posts_path(@user1)
  end

  it 'I can see the first comments on a post.' do
    expect(page).to have_content(@post1.text)
    expect(page).to have_content(@post2.text)
    expect(page).to have_content(@post3.text)
    expect(page).to have_content(@post4.text)
    expect(page).to have_content(@post5.text)
  end

  it 'I can see the user\'s profile picture.' do
    expect(page).to have_css("img[src='#{@user1.photo}']")
  end

  it 'I can see the user\'s name.' do
    expect(page).to have_content(@user1.name)
  end

  it 'I can see the number of posts the user has written.' do
    expect(page).to have_content("Number of posts: #{@user1.posts_counter}")
  end

  it 'I can see a post\'s title' do
    expect(page).to have_content(@post1.title)
  end

  it 'I can see some of the posts\' body' do
    expect(page).to have_content(@post2.text)
    expect(page).to have_content(@post4.text)
  end

  it 'I can see how many comments a post has' do
    @user1.posts.each do |post|
      expect(page).to have_content(post.comments_counter)
    end
  end

  it 'I can see how many likes a post has' do
    @user1.posts.each do |post|
      expect(page).to have_content(post.likes_counter)
    end
  end

  it 'I can see a section for pagination if there are more posts than fit on the view.' do
    expect(page).to have_content('Pagination')
  end

  it 'When I click on a post, it redirects me to that posts show page.' do
    click_link "Post #{@post1.id}"
    expect(page).to have_current_path(user_post_path(@user1, @post1))
  end
end
