class User < ApplicationRecord
    has_and_belongs_to_many :classrooms
    has_many :practice_attendencies
    has_many :practices, through: :practice_attendencies
    has_one :user_modality, dependent: :destroy
    has_one :modality, through: :user_modality

    has_secure_password
    validates :name, :last_name, :email, presence: true
    validates :password, confirmation: true
    validates :email, uniqueness: true

    enum role: ["student", "instructor", "admin"]

    def add_practice(practice)
        if !practices.find_by(id: practice.id)
            practice_attendencies.create(practice_id: practice.id)
        end
    end
end
