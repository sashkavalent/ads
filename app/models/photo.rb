class Photo < ActiveRecord::Base
  attr_accessible :ad_id, :name, :file

  belongs_to :ad

  has_attached_file :file, storage: :dropbox,
    dropbox_credentials: "#{Rails.root}/config/extras/dropbox.yml",
    styles: { medium: "300x300", thumbnail: "100x" },
    dropbox_options: { path: proc { |style| "assets/ads/#{id}/#{style}/#{file_file_name}" } }

  validates :name, presence: true, format: { with: GlobalConstants::Content_regexp }
  validates_attachment_presence :file
  validates_attachment_size :file, less_than: 1.megabytes
  validates_attachment_content_type :file, content_type: /image/

  def image_full
    file.url(download: true)
  end

  def image_thumb
    file.url(:thumbnail)
  end
end
