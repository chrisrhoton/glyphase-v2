require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
    @user = users(:chris)
    # users = User.order(:created_at).take(6)
    35.times do
      title   = Faker::Lorem.words.join(" ")
      tagline = Faker::Lorem.words(5).join(" ")
      content = Faker::Lorem.sentence(5)
      @user.glyphs.create!(content: content, 
                          title: title, 
                          tagline: tagline)
    end
  end

  test "profile display" do
    get user_path(@user)
    assert_template 'users/show'
    assert_select 'title', full_title(@user.username)
    assert_select 'div.caption', text: @user.username
    assert_match @user.glyphs.count.to_s, response.body
    assert_select 'div.pagination'
    @user.glyphs.paginate(page: 1).each do |glyph|
      assert_match glyph.tagline, response.body
    end
  end
end
