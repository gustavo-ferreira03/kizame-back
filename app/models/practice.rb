class Practice < ApplicationRecord
    belongs_to :classroom
    has_many :practice_attendencies

    validates :day, presence: true

    def verify_qr_code(verification_params)
        if qr_code_string == verification_params && day == Date.today
            return true
        else
            return false
        end
    end
end
