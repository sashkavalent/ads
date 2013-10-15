class Photo < ActiveRecord::Base
  attr_accessible :ad_id, :name, :image
  belongs_to :ad
   has_attached_file :image, :styles => { :small => "100x" }, :default_url => "/assets/no_image/:style/no_image_:style.png",
        :url => "ads/:id/:style/:filename",
        :path => ":rails_root/public/assets/ads/:id/:style/:filename"
  # validates_attachment_presence :image
  # validates_attachment_size :image, :less_than => 1.megabytes
  # validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png']
end
