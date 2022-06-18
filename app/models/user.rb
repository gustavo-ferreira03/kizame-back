class User < ApplicationRecord
    has_and_belongs_to_many :classrooms
    has_many :practices, through: :practice_attendencies
    has_one :user_modality, dependent: :destroy
    has_one :modality, through: :user_modality

    has_secure_password
    validates :name, :last_name, :email, :password, :password_confirmation, presence: true
    validates :email, uniqueness: true

    enum role: ["student", "instructor", "admin"]
end
