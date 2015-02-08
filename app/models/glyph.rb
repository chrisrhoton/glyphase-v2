class Glyph < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true
  validates :tagline, presence: true, length: { maximum: 70 }
  validates :title, presence: true, length: { maximum: 70 }
end
