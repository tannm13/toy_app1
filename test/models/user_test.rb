require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
  	@user = User.new(name: "admin2",email: "admin2222222@framgia.com",
  					password: "1234",password_confirmation: "1234");
  end

  test "should be valid" do
  	assert @user.valid?
  end

end
