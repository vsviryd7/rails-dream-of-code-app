class SubmissionsController < ApplicationController
  before_action :set_assignment
  before_action :require_student, only: [:new, :create]
  before_action :require_mentor,  only: [:edit, :update]

  def new
    @submission = Submission.new
    course = @assignment.course
    @enrollment = course.enrollments.find_by(student_id: session[:user_id]) # or user_id
    unless @enrollment
      redirect_to assignment_path(@assignment), alert: "You must be enrolled in this course to submit."
      return
    end
    @lessons = course.lessons
  end

  def create
    course = @assignment.course
    @enrollment = course.enrollments.find_by(student_id: session[:user_id]) # or user_id
    unless @enrollment
      redirect_to assignment_path(@assignment), alert: "You must be enrolled in this course to submit."
      return
    end

    @submission = Submission.new(student_submission_params)
    @submission.enrollment_id = @enrollment.id  # force ownership

    if @submission.save
      redirect_to assignment_path(@assignment), notice: "Submission was successfully created."
    else
      @lessons = course.lessons
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @submission = @assignment.submissions.find(params[:id])
  end

  def update
    @submission = @assignment.submissions.find(params[:id])
    @submission.mentor_id = session[:user_id]
    
    if @submission.update(review_params)
      redirect_to assignment_path(@assignment), notice: "Submission was updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_assignment
    @assignment = Assignment.find(params[:assignment_id])
  end

  # student params ONLY
  def student_submission_params
    params.require(:submission).permit(:lesson_id, :content, :attachment_url, :notes)
  end

  # mentor/admin review params
  def review_params
    params.require(:submission).permit(:mentor_id, :review_result, :reviewed_at)
  end
end