class Comment < ActiveRecord::Base

  belongs_to :ad
  belongs_to :user

  attr_accessible :content
  validates :ad_id, :user_id, :content, :presence => true

  default_scope order: 'comments.created_at DESC'

end
