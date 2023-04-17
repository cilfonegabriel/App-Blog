require 'application_system_test_case'

class UsersTest < ApplicationSystemTestCase
  setup do
    @user = User.create(
      name: 'Name',
      photo: 'https://avatars.githubusercontent.com/u/114885671?v=4',
      bio: 'I am software developer',
      posts_counter: 1
    )
    @post1 = Post.create(author: @user, title: 'This is a post', text: 'This is the post text', comments_counter: 0,
                         likes_counter: 0)
    @post2 = Post.create(author: @user, title: 'This is a second post', text: 'This is the post text',
                         comments_counter: 0, likes_counter: 0)
    @post3 = Post.create(author: @user, title: 'This is a third post', text: 'This is the post text',
                         comments_counter: 0, likes_counter: 0)
    visit root_path
  end

  # User's index page tests

  test 'can see the username of all other users' do
    assert_selector 'h2'
  end
  test 'Can see profile picture of user' do
    assert_selector 'img'
  end
  test 'Can see the number of posts a user has written' do
    assert_selector('.post-count')
  end
  test 'When clicking on a user, I am redirected to that user\'s show page.' do
    click_link(@user.name)
    assert_current_path(user_path(@user))
  end

  # User's show page test

  test 'can see the user\'s profile picture.' do
    visit user_path(@user)
    assert_selector 'img'
  end

  test 'can see the user\'s username.' do
    visit user_path(@user)
    assert_text @user.name
  end

  test 'can see the number of posts the user has written.' do
    visit user_path(@user)
    assert_text "Number of posts: #{@user.posts_counter}"
  end

  test 'can see the user\'s bio.' do
    visit user_path(@user)
    assert_text @user.bio
  end

  test 'can see the user\'s last 3 posts' do
    visit user_path(@user)
    @user.posts.last(3).each do |post|
      assert_text post.id
    end
  end

  test 'can see a button that lets me view all of a user\'s posts.' do
    visit user_path(@user)
    assert_selector :button, 'See all posts'
  end

  test 'When I click a user\'s post, it redirects me to that post\'s show page.' do
    visit user_path(@user)
    find('h4', text: "Post ##{@user.posts.last.id}").click
    assert_current_path(user_post_path(@user, @user.posts.last))
  end

  test 'When I click to see all posts, it redirects me to the user\'s post\'s index page.' do
    visit user_path(@user)
    click_link 'See all posts'
    assert_current_path(user_posts_path(@user))
  end
end