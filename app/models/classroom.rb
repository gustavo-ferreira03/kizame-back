class Classroom < ApplicationRecord
    has_and_belongs_to_many :users
    has_one :modality, through: :classroom_modalities

    validates :name, presence: true
end
