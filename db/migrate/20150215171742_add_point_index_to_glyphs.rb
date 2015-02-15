class AddPointIndexToGlyphs < ActiveRecord::Migration
  def up
    execute %{
      create index index_on_glyphs_location ON glyphs using gist (
        ST_GeographyFromText(
          'SRID=4326;POINT(' || glyphs.longitude || ' ' || glyphs.latitude || ')'
        )
      )
    }
  end

  def down
    execute %{drop index index_on_glyphs_location}
  end
end
