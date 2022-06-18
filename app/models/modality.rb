class Modality < ApplicationRecord
    has_many :classroom_modalities
    has_many :user_modalities
end
