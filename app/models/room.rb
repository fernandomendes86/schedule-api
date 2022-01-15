class Room < ApplicationRecord
  has_many :schedules

  # Format to hour 
  def start_time
    self[:start_time].strftime("%H:%M")
  end

  def end_time
    self[:end_time].strftime("%H:%M")
  end

end
