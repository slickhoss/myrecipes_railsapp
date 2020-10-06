require 'test_helper'

class RecipesEditTest < ActionDispatch::IntegrationTest
  def setup
    @chef = Chef.create(name: 'slickhoss', email: 'slickhoss@example.com', password: 'password', password_confirmation: 'password')
    @recipe1 = Recipe.create(name: 'breakfast', description: 'continental breakfast', chef: @chef)
  end

  test 'valid view / route' do
    get edit_recipe_path(@recipe1)
    assert_response :success
  end

  test 'reject invalid update' do
    get edit_recipe_path(@recipe1)
    assert_template 'recipes/edit'
    patch recipe_path(@recipe1), params: {recipe: {name: '', description: ''} }
    assert_template 'recipes/edit'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end

  test 'successful edit on a recipe' do
    get edit_recipe_path(@recipe1)
    assert_template 'recipes/edit'
    updated_name = 'updated recipe name'
    updated_description = 'updated description'
    patch recipe_path(@recipe1), params: {recipe: {name: updated_name, description: updated_description }}
    #assert_redirected_to @recipe1
    follow_redirect!
    assert_not flash.empty?
    @recipe1.reload
    assert_match updated_name, @recipe1.name
    assert_match updated_description, @recipe1.description
  end
end
