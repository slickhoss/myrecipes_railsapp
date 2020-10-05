require 'test_helper'

class RecipesTest < ActionDispatch::IntegrationTest
  def setup
    @chef = Chef.create(name: 'slickhoss', email: 'slickhoss@example.com')
    @recipe1 = Recipe.create(name: 'breakfast', description: 'continental breakfast', chef: @chef)
    @recipe2 = @chef.recipes.build(name: 'lunch', description: 'club sandwhich')
    @recipe2.save
  end

  test 'should get recipes index page' do
    get recipes_url
    assert_response :success
  end

  test 'should get recipes listing' do
    get recipes_path
    assert_template 'recipes/index'
    assert_select 'a[href=?]', recipe_path(@recipe1), text: @recipe1.name
    assert_select 'a[href=?]', recipe_path(@recipe2), text: @recipe2.name
  end

  test 'should get recipe by id' do
    get recipe_path(@recipe1)
    assert_template 'recipes/show'
    assert_match @recipe1.name, response.body
    assert_select 'a[href=?]', edit_recipe_path(@recipe1), text: 'Edit'
    assert_select 'a[href=?]', recipe_path(@recipe1), text: 'Delete'
  end

  test 'should get recipes new page' do
    get new_recipe_url
    assert_response :success
  end

  test 'create new valid recipe' do
    get new_recipe_path
    assert_template 'recipes/new'
    name_of_recipe = 'pyrex'
    description_of_recipe = 'cooking on the stove wit the pyrex'
    assert_difference 'Recipe.count' do
      post recipes_path, params: {recipe: {name: name_of_recipe, description: description_of_recipe}}
    end
    follow_redirect!
    assert_match name_of_recipe.capitalize, response.body
    assert_match description_of_recipe, response.body
  end

  test 'create new invalid recipe' do
    get new_recipe_path
    assert_template 'recipes/new'
    assert_no_difference 'Recipe.count' do
      post recipes_path, params: { recipe: {name: '', description: '' } }
    end
    assert_template 'recipes/new'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end
end
