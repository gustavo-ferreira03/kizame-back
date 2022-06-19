class ScheduleSerializer < ActiveModel::Serializer
  attributes :id, :from_time, :to_time, :from_weekday, :to_weekday
end
