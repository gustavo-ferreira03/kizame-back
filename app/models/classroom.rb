class Classroom < ApplicationRecord
    has_and_belongs_to_many :members, class_name: "User"
    has_one :classroom_modality
    has_one :modality, through: :classroom_modalities

    validates :name, presence: true

    def instructor
        members.find_by(role: "instructor") || nil
    end

    def students
        members.where(role: "student")
    end
end
