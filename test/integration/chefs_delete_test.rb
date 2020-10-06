require 'test_helper'

class ChefsDeleteTest < ActionDispatch::IntegrationTest
  def setup
    @chef = Chef.create(name: 'slickhoss', email: 'hoongandre@gmail.com', password: 'password', password_confirmation: 'password')
    @recipe1 = Recipe.create(name: 'breakfast', description: 'continental breakfast', chef: @chef)
  end

  test 'succesful delete' do
    get chef_path(@chef)
    assert_template 'chefs/show'
    assert_select 'a[href=?]', chef_path(@chef), text: 'Delete Profile'
    assert_difference 'Chef.count', -1 do
      delete chef_path(@chef)
    end
    follow_redirect!
    assert_template 'chefs/index'
    assert_not flash.empty?
  end

end
