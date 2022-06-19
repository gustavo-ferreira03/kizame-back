class Modality < ApplicationRecord
    has_many :classroom_modalities
    has_many :user_modalities
    
    has_many :classrooms, through: :classroom_modalities
    has_many :users, through: :users_modalities
end
