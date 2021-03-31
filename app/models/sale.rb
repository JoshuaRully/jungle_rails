class Sale < ActiveRecord::Base
  def expired?
    ends_on < Date.current
  end

  def upcoming?
    starts_on > Date.current
  end

  def active?
    !upcoming? && !expired?
  end
end
