require 'test_helper'

class ChefsTest < ActionDispatch::IntegrationTest
  def setup
    @chef = Chef.create(name: 'slickhoss', email: 'slickhoss@example.com', password: 'password', password_confirmation: 'password')
    @recipe1 = Recipe.create(name: 'breakfast', description: 'continental breakfast', chef: @chef)
  end

  test 'test chefs view route' do
    get chefs_path
    assert_response :success
  end

  test 'chef links' do
  get chefs_path
  assert_template 'chefs/index'
  assert_select 'a[href=?]', chef_path(@chef), @chef.name.capitalize
  end

  test 'should delete chefs' do
    get chefs_path
    assert_template 'chefs/index'
  end

end
