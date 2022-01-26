class SerializableSchedule < JSONAPI::Serializable::Resource
  type 'schedules'
  attributes :subject, :start_at, :end_at
  belongs_to :room
end