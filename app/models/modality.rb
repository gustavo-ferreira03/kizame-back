class Modality < ApplicationRecord
    has_many :classroom_modalities
    has_many :user_modalities

    enum name: {
        "Karate" = 0,
        "Jiu-Jitsu" = 1,
        "Krav Maga" = 2,
        "Muay Thai" = 3,
        "Boxe" = 4
    }
end
