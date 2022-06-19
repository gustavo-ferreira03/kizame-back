class Classroom < ApplicationRecord
    has_and_belongs_to_many :members, class_name: "User"
    has_one :schedule, dependent: :destroy
    has_one :classroom_modality, dependent: :destroy
    has_one :modality, through: :classroom_modality
    has_many :practices

    validates :name, presence: true

    def instructor
        members.find_by(role: "instructor") || nil
    end

    def students
        members.where(role: "student")
    end

    def user_in_classroom?(user)
        if students.include?(user)
            return true
        else
            return false
        end
    end

    def add_user(user)
        members.append(user) and return true unless members.find_by(id: user.id)
    end

    def remove_user(user)
        if members.find_by(id: user.id)
            members.destroy(user.id)
            return true
        end
    end
end
