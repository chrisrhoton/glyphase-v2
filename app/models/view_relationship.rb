class ViewRelationship < ActiveRecord::Base
  belongs_to :user
  belongs_to :glyph
  validates :user_id, presence: true
  validates :glyph_id, presence: true
end