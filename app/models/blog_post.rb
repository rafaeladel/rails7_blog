class BlogPost < ApplicationRecord
    validates :title, presence: true
    validates :body, presence: true
    validates :email, uniqueness: true, presence: true

    default_scope { order(arel_table["published_at"].desc.nulls_last) }
    #default_scope { order(Arel.sql("published_at DESC NULLS LAST")) }
    scope :draft, -> { where(published_at: nil) }
    scope :scheduled, -> { where("published_at > ?", Time.now) }
    scope :published, -> { where("published_at <= ?", Time.now) }

    mount_uploader :image, ImageUploader 
    has_one_attached :cover do |attachable|
      attachable.variant :thumb, resize_to_limit: [100, 100]
    end

    def published_at_string
        published_at&.to_formatted_s(:long)
    end

    def draft?
        published_at.nil?
    end

    def scheduled?
      published_at? && published_at > Time.now
    end

    def published?
      published_at? && published_at <= Time.now
    end

    def state
      return :draft if draft?
      return :scheduled if scheduled?
      return :published if published?
    end
end
