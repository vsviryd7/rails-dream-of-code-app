#Task 1: Create Courses for Spring 2026
spring_2026 = Trimester.create(
  year: '2026', 
  term: 'Spring', 
  application_deadline: '2026-02-15', 
  start_date: "2026-03-01", 
  end_date: "2026-06-30"
  )
#loop 
CodingClass.all.each do |coding_class|
  puts coding_class.title
end
#Create courses for each coding class in the Spring 2026 trimester
CodingClass.all.each do |coding_class|
  Course.create(
    coding_class_id: coding_class.id,
    trimester_id: spring_2026.id
    )
end

#check my addition spring2026
Course.where(trimester_id: spring_2026.id).includes(:coding_class).each do |course|
  puts "#{course.coding_class.title} — Spring 2026"
end
#Existing Coding Classes for Spring 2026
#Intro to Programming — Spring 2026
#React — Spring 2026
#NodeJS — Spring 2026
#Ruby on Rails — Spring 2026
#Python — Spring 2026

#Task2Create a new student record and enroll the student in the Intro to Programming course for the Spring 2026 trimester.
new_student = Student.create(
  first_name: 'Olga',
  last_name: 'Sviridenko',
  email: 'ol.sviridenko777@gmail.com'
)

spring_2026 = Trimester.find_by(year: "2026", term: "Spring")
intro_class = CodingClass.find_by(title: "Intro to Programming")
intro_course = Course.find_by(
  coding_class_id: intro_class.id,
  trimester_id: spring_2026.id
)

enrollment = Enrollment.create(
  student_id: new_student.id,
  course_id: intro_course.id
)

mentor = Mentor.all.find do |m|
  m.mentor_enrollment_assignments.count <= 2
end
mentor_enrollment_assignment = MentorEnrollmentAssignment.create(
  enrollment_id: enrollment.id,
  mentor_id: mentor.id
) 

puts "New student enrolled: #{new_student.first_name} #{new_student.last_name}, Email: #{new_student.email}"
puts student.inspect

=begin
Task3 - Describe your project
Project Title: ActiveMeet – Outdoor Sports Meetup App

Description:
ActiveMeet is a simple application that helps people find and join outdoor sports and activity meetups. The app allows users to create events like soccer games, basketball, hikes, yoga sessions, or bike rides — and invite others in the area to join.
Who are the users of the app?
The users are everyday people who want to be active and meet others through sports or outdoor activities. All users have the same role — there are no admins or special user types in the basic version.
Core features and user scenarios:
A user can create a profile with their name, location, and favorite sport.
A user can create an event with:
Sport type (e.g., soccer, yoga, hiking)
Location (e.g., park or trail)
Date and time
How many players or people are needed
A user can view a list of upcoming sport events.
A user can join an event.
A user can see the list of players who joined an event.
A user can cancel an event they created.

App flow example:
A new user signs up with their name and favorite sport.
The user creates an event: “Basketball at Romare Park, Saturday at 4 PM.”
Other users see this event and decide to join.
The event shows a list of people who have joined so far.
After the event, the host can choose to create another event, or others can create their own.

(Optional for later versions):
Users can leave feedback or ratings on events.
Users can message each other before the event.

Task 4 - Data Model Design
Tables (Models) and their columns:
1. users
id (primary key, integer)
name (string)
location (string)
favorite_sport (string)
created_at (datetime)
updated_at (datetime)

2. events
id (primary key, integer)
sport (string)
location (string)
event_time (datetime)
players_needed (integer)
host_id (integer, foreign key references users.id)
created_at (datetime)
updated_at (datetime)

3. event_participants (join table between users and events for many-to-many relationship)
id (primary key, integer)
user_id (integer, foreign key references users.id)
event_id (integer, foreign key references events.id)
created_at (datetime)
updated_at (datetime)

Relationships:
A User can host many Events (has_many :events, foreign_key: :host_id)
A User can join many Events through event_participants (has_many :event_participants and has_many :events, through: :event_participants)
An Event belongs to one User as host (belongs_to :host, class_name: "User")
An Event has many Users as participants through event_participants (has_many :event_participants and has_many :users, through: :event_participants)
=end