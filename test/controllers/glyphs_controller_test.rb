require 'test_helper'

class GlyphsControllerTest < ActionController::TestCase
  def setup
    @glyph = glyphs(:orange)
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Glyph.count' do
      post :create, glyph: { content: "Lorem ipsum",
                             tagline: "Great spot for rails",
                             title: "Rails playground" }
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Glyph.count' do
      delete :destroy, id: @glyph
    end
    assert_redirected_to login_url
  end
end
