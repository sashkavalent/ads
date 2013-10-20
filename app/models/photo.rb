class Photo < ActiveRecord::Base
  attr_accessible :ad_id, :name, :file
  belongs_to :ad
  has_attached_file :file, :storage => :dropbox, :dropbox_credentials => "#{Rails.root}/config/extras/dropbox.yml", :styles => { :medium => "300x300", :thumbnail => "100x100" }, :dropbox_options => { :path => proc { |style| "assets/ads/#{id}/#{style}/#{file_file_name}" }
    }
  def image_full
    file.url(:download => true)
  end
  def image_thumb
    file.url(:thumbnail)
    # "https://www.dropbox.com/home/Public/assets/ads/#{id}/thumbnail/#{file_file_name}"
  end
  # has_attached_file :file, styles: { thumbnail: '100x100>' }, :default_url => "/assets/no_image/:style/no_image_:style.png",
  #       :url => "ads/:id/:style/:filename",
  #       :path => ":rails_root/public/assets/ads/:id/:style/:filename"
  # def image_full
  #   "assets/ads/#{id}/original/#{file_file_name}"
  # end
  # def image_thumb
  #   "ads/#{id}/thumbnail/#{file_file_name}"
  # end
  # validates_attachment_presence :image
  # validates_attachment_size :image, :less_than => 1.megabytes
  # validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png']
end