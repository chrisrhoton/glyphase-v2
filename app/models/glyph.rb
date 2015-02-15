class Glyph < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy
  default_scope -> { order(created_at: :desc) }
  mount_uploader :image_attachment, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true
  validates :tagline, presence: true, length: { maximum: 70 }
  validates :title, presence: true, length: { maximum: 70 }
  validate  :image_size

  scope :close_to, -> (latitude, longitude, distance_in_meters = 2000) {
    where(%{
      ST_DWithin(
        ST_GeographyFromText(
          'SRID=4326;POINT(' || glyphs.longitude || ' ' || glyphs.latitude || ')'
        ),
        ST_GeographyFromText('SRID=4326;POINT(%f %f)'),
        %d
      )
    } % [longitude, latitude, distance_in_meters])
  }

  private

    # Validates the size of an uploaded picture.
    def image_size
      if image_attachment.size > 5.megabytes
        errors.add(:image_attachment, "should be less than 5MB")
      end
    end
end
