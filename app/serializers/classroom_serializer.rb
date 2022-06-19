class ClassroomSerializer < ActiveModel::Serializer
  attributes :id, :name
  attribute :modality_name
  attribute :instructor_name
  has_many :students
  attribute :student_count
  
  def instructor_name
    "#{self.object.instructor.name} #{self.object.instructor.last_name}"
  end

  def student_count
    self.object.students.count
  end

  def modality_name
    self.object.modality.name
  end
end
