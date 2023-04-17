require 'application_system_test_case'

class UsersTest < ApplicationSystemTestCase
  test 'can see the username of all other users' do
  setup do
    @user = User.create(name: 'Name', photo: 'https://avatars.githubusercontent.com/u/114885671?v=4', bio: 'I am software developer',
                        posts_counter: 1)
    visit root_path
    assert_selector 'h1', text: 'Users'
  end
end

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
end