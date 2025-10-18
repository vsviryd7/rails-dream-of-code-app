class Api::V1::CoursesController < ApplicationController

  def index
    current_trimester = Trimester.where('start_date <= ? AND end_date >= ?', Date.today, Date.today)
    courses = Course.joins(:coding_class, :trimester)
                    .where(trimester: current_trimester)
    courses_array = courses.map do |course|
      {
        id: course.id,
        title: course.coding_class.title,
        application_deadline: course.trimester.application_deadline,
        start_date: course.trimester.start_date,
        end_date: course.trimester.end_date
      }
    end
    render json: { courses: courses_array }, status: :ok
  end

end
