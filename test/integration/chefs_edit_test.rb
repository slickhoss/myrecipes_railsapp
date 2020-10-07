require 'test_helper'

class ChefsEditTest < ActionDispatch::IntegrationTest
  def setup
    @chef = Chef.create(name: 'slickhoss', email: 'hoongandre@gmail.com', password: 'password', password_confirmation: 'password')
    @recipe1 = Recipe.create(name: 'breakfast', description: 'continental breakfast', chef: @chef)
    sign_in_as(@chef, @chef.password)
    @admin = Chef.create(name: 'admin', email: 'admin@example.com', password: 'password', password_confirmation: 'password', admin: true)
    @chef2 = Chef.create(name: 'chef', email: 'chef@example.com', password: 'password', password_confirmation: 'password')
  end

  test 'chef edit route' do
    get edit_chef_path(@chef)
    assert_response  :success
  end

  test 'succesful edit' do
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path(@chef), params: {chef: {name: 'andre', email: @chef.email, password: @chef.password, password_confirmation: @chef.password_confirmation}} 
    assert_redirected_to @chef
    @chef.reload
    assert_match 'andre', @chef.name
  end

  test 'failed edit' do
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path(@chef), params: {chef: {name: '', email: '', password: '', password_confirmation: ''}}
    assert_template 'chefs/edit'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end

  test 'accept edit attempt by admin user' do
    sign_in_as(@admin, @admin.password)
    updated_name = 'slickhoss'
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path(@chef), params: {chef: {name: updated_name, email: @chef.email , password: @chef.password, password_confirmation: @chef.password_confirmation}}
    assert_redirected_to @chef
    @chef.reload
    assert_match updated_name, @chef.name
    
  end

  test 'redirect by non admin user' do
    sign_in_as(@chef2, @chef2.password)
    get edit_chef_path(@chef)
    assert_redirected_to @chef2
    assert_not flash.empty?
  end

end
