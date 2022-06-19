class ClassroomSerializer < ActiveModel::Serializer
  attributes :id, :name
  attribute :modality_name

  def modality_name
    self.object.modality.name
  end
end
