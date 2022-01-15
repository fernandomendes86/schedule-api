class Schedule < ApplicationRecord
  belongs_to :room

  validates :subject, :start_at, :end_at, presence: true
  validate :valid_time?

  # I18n format
  def start_at
    I18n.l(self[:start_at]) rescue nil
  end

  def end_at
    I18n.l(self[:end_at]) rescue nil
  end

  private

    def valid_time?
      unless (start_at_valid? && end_at_valid?)
        errors.add(:base, "Invalid time")
      end
    end

    def start_at_valid?
      (room.start_time..room.end_time).include?(self.start_at.to_time.to_s(:time))
    end

    def end_at_valid?
      (room.start_time..room.end_time).include?(self.end_at.to_time.to_s(:time))
    end

end
