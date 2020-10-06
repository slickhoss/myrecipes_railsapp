require 'test_helper'

class ChefsSignupTest < ActionDispatch::IntegrationTest
  def setup
    @chef = Chef.new(name: 'slickhoss', email: 'hoongandre@gmail.com', password: 'password', password_confirmation: 'password')  
  end
  
  test 'should get signup path' do
    get new_chef_path
    assert_response :success
  end

  test 'successful sign up' do
    get new_chef_path
    assert_template 'chefs/new'
    assert_difference 'Chef.count' do
      post chefs_path, params: {chef: {name: @chef.name, email: @chef.email, password: @chef.password, password_confirmation: @chef.password_confirmation}}
    end
    follow_redirect!
    assert_match @chef.name, response.body
    assert_match @chef.email, response.body
  end

  test 'invalid sign up' do
    get new_chef_path
    assert_template 'chefs/new'
    assert_no_difference 'Chef.count' do
      post chefs_path, params: {chef: {name: '', email: '', password: '', password_confirmation: ''}}
    end
    assert_template 'chefs/new'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end

end
