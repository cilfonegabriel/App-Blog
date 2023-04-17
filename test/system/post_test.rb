require 'application_system_test_case'

class UsersTest < ApplicationSystemTestCase
  test 'can see the username' do
    visit root_path
    assert_selector 'h1', text: 'Users'
  end
end
