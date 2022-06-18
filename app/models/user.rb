class User < ApplicationRecord
    has_and_belongs_to_many :classrooms
    has_many :practices, through: :practice_attendencies
    has_one :modality, through: :user_modality
end
