class SerializableRoom < JSONAPI::Serializable::Resource
  type 'rooms'
  attributes :description, :start_time, :end_time
end
