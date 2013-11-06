ThinkingSphinx::Index.define :ad, :with => :active_record do
  indexes content
  indexes state
  indexes ad_type_id

  has created_at, published_at
end
