require 'test_helper'

class GlyphTest < ActiveSupport::TestCase
  def setup
    @user = users(:chris)
    @glyph = @user.glyphs.build(content: "Lorem ipsum", 
                                tagline: "Best for precisions",
                                title: "Dope Spot", 
                                user_id: @user.id)
  end

  test "should be valid" do
    assert @glyph.valid?
  end

  test "user id should be present" do
    @glyph.user_id = nil
    assert_not @glyph.valid?
  end

  test "content should be present " do
    @glyph.content = "   "
    assert_not @glyph.valid?
  end

  test "title should be present " do
    @glyph.title = "   "
    assert_not @glyph.valid?
  end

  test "title should be at most 70 characters" do
    @glyph.title = "a" * 71
    assert_not @glyph.valid?
  end

  test "tagline should be present " do
    @glyph.tagline = "   "
    assert_not @glyph.valid?
  end

  test "tagline should be at most 70 characters" do
    @glyph.tagline = "a" * 71
    assert_not @glyph.valid?
  end

  test "order should be most recent first" do
    assert_equal Glyph.first, glyphs(:most_recent)
  end
end
