class TrimestersController < ApplicationController
  before_action :require_admin, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_trimester, only: [:show, :edit, :update, :destroy]

  def index
    @trimesters = Trimester.order(year: :desc, term: :asc)
  end

  def show
  end

  def new
    @trimester = Trimester.new
  end

  def create
    @trimester = Trimester.new(trimester_params)
    if @trimester.save
      redirect_to @trimester, notice: "Trimester was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @trimester.update(trimester_params)
      redirect_to @trimester, notice: "Trimester was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @trimester.destroy
    redirect_to trimesters_path, notice: "Trimester was successfully deleted."
  end

  private

  def set_trimester
    @trimester = Trimester.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to trimesters_path, alert: "Trimester not found."
  end

  def trimester_params
    params.require(:trimester).permit(:term, :year, :start_date, :end_date, :application_deadline)
  end
end