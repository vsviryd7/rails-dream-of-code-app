class Api::V1::EnrollmentsController < ApplicationController
  def index
    current_trimester = Trimester.find_by("start_date <= ? AND end_date >= ?", Date.today, Date.today)
    course = Course.find_by(id: params[:course_id], trimester_id: current_trimester.id)
    enrollments = course.enrollments.includes(:student) if course
    return render json: { course_id: params[:course_id].to_i, enrollments: [] }, status: :ok unless current_trimester

    unless course
      render json: { enrollments: [], message: "No course found for the current trimester" }, status: :ok
      return
    end

    enrollments_array = course.enrollments.map do |enrollment|
      {
        id: enrollment.id,
        student_id: enrollment.student_id,
        student_first_name: enrollment.student.first_name,
        student_last_name: enrollment.student.last_name,
        final_grade: enrollment.final_grade
      }
    end

    render json: { enrollments: enrollments_array }, status: :ok
  end
end
