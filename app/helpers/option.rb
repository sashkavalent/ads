module Option

  def before_destroy
    if !self.ads.blank?
      errors.add(:ads, 'must be blank')
      false
    end
  end

end
