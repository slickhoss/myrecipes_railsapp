require 'test_helper'

class ChefTest < ActiveSupport::TestCase
  def setup
    @chef = Chef.new(name: 'chef', email: 'chef@example.com')
  end

  test 'chef should be valid' do
    assert @chef.valid?
  end

  test 'name should be present' do
    @chef.name = ''
    assert_not @chef.valid?
  end

  test 'name should be less than 2 characters' do
    @chef.name = 'a'
    assert_not @chef.valid?
  end

  test 'name should not be greater than 30 characters' do
    @chef.name = 'a' * 31
    assert_not @chef.valid?
  end

  test 'email should be present' do
    @chef.email = ''
    assert_not @chef.valid?
  end

  test 'email should be less than 255' do
    @chef.email = 'a' * 300
    assert_not @chef.valid?
  end

  test 'accepts email in correct format' do
    valid_emails = %w[user@example.com SLICKHOSS@gmail.com m.first@yahoo.ca john+smith@hotmail.com]
    valid_emails.each do |valids|
      @chef.email = valids
      assert @chef.valid?, "#{valids.inspect} should be valid"
    end
  end


  test 'denies email in incorrect format' do
    @chef.email ='h_andre'
    assert_not @chef.valid?
  end

  test 'email should be unique' do
    duplicate_chef = @chef.dup
    duplicate_chef.email = @chef.email.upcase
    @chef.save
    assert_not duplicate_chef.valid?
  end

  test 'email should be lowercase before saved' do
    mixed_email = 'johnDOE@example.com'
    @chef.email = mixed_email
    @chef.save
    assert_equal mixed_email.downcase, @chef.reload.email
  end

end
