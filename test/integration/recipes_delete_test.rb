require 'test_helper'

class RecipesDeleteTest < ActionDispatch::IntegrationTest
  def setup
    @chef = Chef.create(name: 'slickhoss', email: 'slickhoss@example.com', password: 'password', password_confirmation: 'password')
    @recipe1 = Recipe.create(name: 'breakfast', description: 'continental breakfast', chef: @chef)
    sign_in_as(@chef, @chef.password)

  end

  test 'succesful delete' do
    get recipe_path(@recipe1)
    assert_template 'recipes/show'
    assert_select 'a[href=?]', recipe_path(@recipe1), text: 'Delete'
    assert_difference 'Recipe.count', -1 do
      delete recipe_path(@recipe1)
    end
    assert_redirected_to recipes_path
    assert_not flash.empty?
  end

end
