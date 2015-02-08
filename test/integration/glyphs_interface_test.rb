require 'test_helper'

class GlyphsInterfaceTest < ActionDispatch::IntegrationTest
  def setup
    @user   = users(:chris)
    @archer = users(:archer)
  end

  test "glyph interface" do
    log_in_as(@user)
    get new_glyph_path
    # Invalid submission
    post glyphs_path, glyph: { content: "" }
    assert_select 'div#error_explanation'
    # # Valid submission
    content = "This glyph really ties the room together"
    tagline = "Best glyph ever"
    title = "The Dude"
    post glyphs_path, glyph: { content: content, tagline: tagline, title: title }
    glyph = assigns(:glyph)
    assert_redirected_to glyph
    follow_redirect!
    assert_match content, response.body
    # Delete a post.
    get user_path(@user)
    assert_match tagline, response.body
    assert_select 'a', text: 'Delete'
    first_glyph = @user.glyphs.paginate(page: 1).first
    assert_difference 'Glyph.count', -1 do
      delete glyph_path(first_glyph)
    end
    # Visit a different user.
    get user_path(@archer)
    assert_select 'a', text: 'delete', count: 0
  end
end
