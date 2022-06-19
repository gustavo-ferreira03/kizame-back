class Practice < ApplicationRecord
    belongs_to :classroom
    has_many :practice_attendencies

    validates :day, presence: true
end
