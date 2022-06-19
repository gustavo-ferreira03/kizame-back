class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :last_name, :email, :profile_picture_link, :role
  has_one :modality
  has_many :classrooms
  has_many :practices
end
