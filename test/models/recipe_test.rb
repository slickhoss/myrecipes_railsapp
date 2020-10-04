require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
  def setup
    @recipe = Recipe.new(name: "vegtable", description: "great vegtable recipe", chef_id: 2)
  end

  test "recipe should be valid" do
    assert @recipe.valid?
  end

  test 'name should be present' do
    @recipe.name = ''
    assert_not @recipe.valid?
  end

  test 'description should be present' do
    @recipe.description = ''
    assert_not @recipe.valid?
  end

  test 'description should be greater than 5 characters' do
    @recipe.description = 'aaaa'
    assert_not @recipe.valid?
  end

  test 'description should be less than 500 characters' do
    @recipe.description = 'a' * 501
    assert_not @recipe.valid?
  end

  test 'chef_id should be present' do
    @recipe.chef_id = nil
    assert_not @recipe.valid?
  end

end
