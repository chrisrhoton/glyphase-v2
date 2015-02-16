class Glyph < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :view_relationships, dependent: :destroy
  has_many :viewers, through: :view_relationships, source: :user
  default_scope -> { order(created_at: :desc) }
  mount_uploader :image_attachment, PictureUploader
  mount_uploader :header_image, HeaderUploader
  validates :user_id, presence: true
  validates :content, presence: true
  validates :tagline, presence: true, length: { maximum: 70 }
  validates :title, presence: true, length: { maximum: 70 }
  validate  :image_size
  reverse_geocoded_by :latitude, :longitude

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

  def add_viewer!(other_user)
    view_relationships.create!(user_id: other_user.id)
  end

  private

    # Validates the size of an uploaded picture.
    def image_size
      if image_attachment.size > 5.megabytes
        errors.add(:image_attachment, "should be less than 5MB")
      end

      if header_image.size > 5.megabytes
        errors.add(:header_image, "should be less than 5MB")
      end
    end
end
