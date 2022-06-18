class User < ApplicationRecord
    has_and_belongs_to_many :classrooms
    has_many :practices, through: :practice_attendencies
    has_one :modality, through: :user_modality

    validates :name, :last_name, :email, presence: true
    validates :email, uniqueness: true
    validates :password, confirmation: true
    validates :password_confirmation, presence: true

    enum role: {
        "administrator" = 0,
        "teacher" = 1,
        "student" = 2
    }

end
