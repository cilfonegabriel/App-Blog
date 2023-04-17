require 'rails_helper'

RSpec.describe 'User index page - ', type: :feature do
  before(:each) do
    @user1 = User.create(
      name: 'User 1',
      photo: 'https://unsplash.com/photos/Hekapoo',
      bio: 'User 1 bio',
      posts_counter: 0
    )
    @user2 = User.create(
      name: 'User 2',
      photo: 'https://unsplash.com/photos/Peloton',
      bio: 'User 2 bio',
      posts_counter: 1
    )
    @user3 = User.create(
      name: 'User 3',
      photo: 'https://unsplash.com/photos/Tart',
      bio: 'User 3 bio',
      posts_counter: 2
    )
    visit users_path
  end

  it 'can see the username of all other users' do
    expect(page).to have_content(@user1.name)
    expect(page).to have_content(@user2.name)
    expect(page).to have_content(@user3.name)
  end

  it ' can see the profile picture for each user' do
    expect(page).to have_css("img[src='#{@user1.photo}']")
  end

  it ' can see the number of posts each user has written.' do
    expect(page).to have_content("Number of posts: #{@user1.posts_counter}")
    expect(page).to have_content("Number of posts: #{@user2.posts_counter}")
    expect(page).to have_content("Number of posts: #{@user3.posts_counter}")
  end

  it 'When I click on a user, I am redirected to that user\'s show page' do
    click_link @user2.name
    expect(page).to have_current_path(user_path(@user2))
  end
end
