<<<<<<< HEAD
class Course < ApplicationRecord
  belongs_to :coding_class
  belongs_to :trimester
  has_many :enrollments

  delegate :title, to: :coding_class
  def student_name_list
    list_studens = []
    enrollments.each do |enrollment| 
      list_studens << "#{enrollment.student.first_name} #{enrollment.student.last_name}"
    end 
    list_studens
  end

  def student_email_list
    email_studens = []
    enrollments.each do |enrollment| 
      email_studens << enrollment.student.email
    end 
    email_studens
  end
end
=======
class Course < ApplicationRecord
  belongs_to :coding_class
  belongs_to :trimester
  has_many :enrollments

  delegate :title, to: :coding_class
  
end
>>>>>>> main
