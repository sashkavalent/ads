ThinkingSphinx::Index.define :ad, :with => :active_record do
  indexes content
  indexes state
  indexes ad_type_id

  indexes user(:first_name)
  indexes user(:last_name)

  indexes subsection(:name)
  indexes place(:name)
  indexes keywords(:name)
  indexes subsection.section.name, :as => :section

  has created_at, published_at
end
