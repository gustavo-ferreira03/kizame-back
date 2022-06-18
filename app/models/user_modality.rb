class UserModality < ApplicationRecord
    belongs_to :user
    belongs_to :modality
end
