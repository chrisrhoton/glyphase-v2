module GlyphsHelper

  DEFAULT_PROXIMITY = 0.02 # 20 meters

  def get_latitude
    cookies[:user_lat]
  end

  def get_longitude
    cookies[:user_lng]
  end

  def close_enough?(glyph)
    DEFAULT_PROXIMITY > glyph.distance_from([get_latitude, get_longitude])
  end
end
