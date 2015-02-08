require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(username: "Example", email: "user@example.com",
                     password: "foobar", password_confirmation: "foobar")
  end

  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?(:remember, '')
  end

  test "associated microposts should be destroyed" do
    @user.save
    @user.glyphs.create!(content: "Lorem ipsum",
                         title: "Dope Site",
                         tagline: "Cat's Delight")
    assert_difference 'Glyph.count', -1 do
      @user.destroy
    end
  end

end
