class Schedule < ApplicationRecord
  belongs_to :room

  validates :subject, :start_at, :end_at, presence: true
  validate :valid_time?, :monday_to_friday?, :some_day?, :some_room_day_time?, :end_less_start_time?

  # I18n format
  def start_at
    I18n.l(self[:start_at]) rescue nil
  end

  def end_at
    I18n.l(self[:end_at]) rescue nil
  end

  def valid_time?
    unless (start_at_valid? && end_at_valid?)
      errors.add(:base, "Invalid time")
    end
  end

  def monday_to_friday?
    if self.start_at.to_time.saturday? || self.end_at.to_time.saturday?
      errors.add(:base, "Saturday is invalid")
    elsif self.start_at.to_time.sunday? || self.end_at.to_time.sunday?
      errors.add(:base, "Sunday is invalid")
    end
  end

  def some_day?
    unless (self.start_at.to_date == self.end_at.to_date)
      errors.add(:base, "Different days is invalid")
    end
  end

  def end_less_start_time?
    if self.end_at.to_time <= self.start_at.to_time 
      errors.add(:base, "End time is less than start time")
    end
  end

  def some_room_day_time?
    if self.some_room_time
      errors.add(:base, "Same room day and time")
    end
  end

  def some_room_time
    range = (self.start_at.to_time-1.minute..self.end_at.to_time-1.minute)
    array = Schedule.where(room: self.room).select{|s| 
      (range.include? s.start_at.to_time) || (range.include? s.end_at.to_time)
    }
    array.delete_if{ |x| x.id == self.id || x.end_at.to_time == self.start_at.to_time  }.present?
  end


  private

    def start_at_valid?
      (room.start_time..room.end_time).include?(self.start_at.to_time.to_s(:time))
    end

    def end_at_valid?
      (room.start_time..room.end_time).include?(self.end_at.to_time.to_s(:time))
    end

end
