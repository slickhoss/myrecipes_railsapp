require 'test_helper'

class ChefsShowTest < ActionDispatch::IntegrationTest
  def setup
    @chef = Chef.create(name: 'slickhoss', email: 'slickhoss@example.com', password: 'password', password_confirmation: 'password')
    @recipe1 = Recipe.create(name: 'breakfast', description: 'continental breakfast', chef: @chef)
    @recipe2 = @chef.recipes.build(name: 'lunch', description: 'club sandwhich')
    @recipe2.save
    sign_in_as(@chef, @chef.password)
  end

  test 'test chef show route' do
    get chef_path(@chef)
    assert_template 'chefs/show'
    assert_match @chef.name, response.body
    assert_select 'a[href=?]', recipe_path(@recipe1), text: @recipe1.name
    assert_match @recipe1.description, response.body
    assert_select 'a[href=?]', recipe_path(@recipe2), text: @recipe2.name
    assert_match @recipe2.description, response.body
  end
 
  
end
