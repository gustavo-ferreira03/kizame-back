class Schedule < ApplicationRecord
  belongs_to :classroom

  validates_presence_of :from_weekday, :to_weekday, :from_time, :to_time
  validates :from_weekday, :to_weekday, inclusion: { in: 0..6 }
  validates :from_time, :to_time, inclusion: { in: 0..23 }
  validates :to_weekday, comparison: { greater_than: :from_weekday }
  validates :to_time, comparison: { greater_than: :from_time }

  def in_schedule?
      if in_weekday? && in_time?
        return true
      else
        return false
      end
  end

  private

    def in_weekday?
      current_weekday = Time.now.wday
      return (current_weekday >= from_weekday && current_weekday <= to_weekday)
    end

    def in_time?
      current_time = Time.now.hour
      return (current_time >= from_time && current_time <= to_time)
    end
end
