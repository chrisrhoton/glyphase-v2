class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :glyph
  validates :text, presence: true
  mount_uploader :image_attachment, PictureUploader
  validates :user_id, presence: true
  validates :glyph_id, presence: true
  validate  :image_size

  private
    # Validates the size of an uploaded picture.
    def image_size
      if image_attachment.size > 5.megabytes
        errors.add(:image_attachment, "should be less than 5MB")
      end
    end
end
