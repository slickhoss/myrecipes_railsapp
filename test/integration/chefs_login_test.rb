require 'test_helper'

class ChefsLoginTest < ActionDispatch::IntegrationTest
  def setup
    @chef = Chef.create(name: "Craig Eastwood", email: "craig@test.com", password: "password")
  end


  test "valid login credentials accepted and begin session" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email: @chef.email, 
                                    password: @chef.password } }
    follow_redirect!
    assert_select 'a[href=?]', logout_path, text: 'Logout'
    assert_select 'a[href=?]', login_path, text: 'Login', count: 0
  end

  test "invalid login is rejected" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email: " ", 
                                              password: " " } }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
    assert_select 'a[href=?]', login_path, text: 'Login'
    assert_select 'a[href=?]', logout_path, text: 'Logout', count: 0
  end
  
end
