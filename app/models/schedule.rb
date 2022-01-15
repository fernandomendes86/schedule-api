class Schedule < ApplicationRecord
  belongs_to :room

  # I18n format
  def start_at
    I18n.l(self[:start_at]) rescue nil
  end

  def end_at
    I18n.l(self[:end_at]) rescue nil
  end

end
