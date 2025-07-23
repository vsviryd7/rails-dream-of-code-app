#Task1
CodingClass.find_by({ title: 'Intro to Programming' })
Trimester.find_by(year: '2025', term: 'Spring')
Course.find_by({trimester_id:5,coding_class_id:1})
enrollments = Enrollment.where(course_id:5)

enrollments.first(2).each do |enrollment|
  student = Student.find(enrollment.student_id)
  puts "#{student.id},#{student.email}"
end

# Task 2
CodingClass.find_by({ title: 'Intro to Programming' })
Trimester.find_by(year: '2025', term: 'Spring')
Course.find_by({trimester_id:5,coding_class_id:1})
enrollments = Enrollment.where(course_id:5,final_grade:nil)

enrollments.each do |enrollment|
  assignment_mentor = MentorEnrollmentAssignment.find_by({enrollment_id:enrollment.id})
  mentor = Mentor.find_by(id:assignment_mentor.mentor_id)
  puts "#{mentor.id},#{mentor.email}"
end
