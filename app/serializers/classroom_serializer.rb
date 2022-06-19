class ClassroomSerializer < ActiveModel::Serializer
  attributes :id, :name
  attribute :modality_name
  attribute :instructor_name
  attribute :students
  
  def instructor_name
    "#{self.object.instructor.name} #{self.object.instructor.last_name}"
  end

  def students
    self.object.students.map { |t| t.id }
  end

  def modality_name
    self.object.modality.name
  end
end
