require 'test_helper'

class GlyphsControllerTest < ActionController::TestCase
  def setup
    @glyph = glyphs(:orange)
    @user = users(:archer)
    @archers_glyph = @user.glyphs.build(content: "Lorem ipsum", 
                                        tagline: "Best for precisions",
                                        title: "Dope Spot", 
                                        user_id: @user.id)
    @archers_glyph.save
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

  test "should redirect destroy for wrong glyph" do
    log_in_as(users(:chris))
    assert_no_difference 'Glyph.count' do
      delete :destroy, id: @archers_glyph
    end
    assert_redirected_to root_url
  end
end
