class TrimestersController < ApplicationController
  before_action :set_trimester, only: [:show, :edit, :update]

  def index
    @trimesters = Trimester.all
    @mentors = Mentor.all 
  end
  def show
    @trimester = Trimester.find(params[:id])
    @mentors = Mentor.all
  end
  def edit
    # @trimester is set by before_action
  end

  def update
    if params[:trimester][:application_deadline].blank?
      render plain: "Application deadline required", status: :bad_request
    elsif !valid_date?(params[:trimester][:application_deadline])
      render plain: "Invalid date format", status: :bad_request
    elsif @trimester.update(trimester_params)
      redirect_to @trimester, notice: "Trimester was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_trimester
    @trimester = Trimester.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render plain: "Not Found", status: :not_found
  end

  def trimester_params
    params.require(:trimester).permit(:year, :term, :application_deadline, :start_date, :end_date)
  end

  def valid_date?(date_str)
    Date.parse(date_str)
    true
  rescue ArgumentError
    false
  end

end