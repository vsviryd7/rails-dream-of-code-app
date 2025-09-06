class AdminDashboardController < ApplicationController
  def index
    @current_trimester = Trimester.where('start_date <= ? AND end_date >= ?', Date.today, Date.today).first
    @upcoming_trimester = Trimester.where('start_date > ?', Date.today).first
    @coding_classes = CodingClass.all
  end
end
