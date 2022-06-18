class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :last_name, :email, :profile_picture_link, :role
  attribute :modalities
  attribute :classrooms
end
