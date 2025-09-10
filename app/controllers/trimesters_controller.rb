class TrimestersController < ApplicationController

  def index
    @trimesters = Trimester.all
    @mentors = Mentor.all 
  end
  def show
    @trimester = Trimester.find(params[:id])
    @mentors = Mentor.all
  end

  
end