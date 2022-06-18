class Practice < ApplicationRecord
    belongs_to :classroom
    has_and_belongs_to_many :users

    validates :day, presence: true
end
