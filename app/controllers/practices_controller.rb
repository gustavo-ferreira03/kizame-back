class PracticesController < ApplicationController
  before_action :verify_authenticated
  before_action :set_classroom
  before_action :verify_instructor, only: :create
  before_action :verify_student, only: :verification
  before_action :set_practice, only: :verification

  def create
    if !@classroom.practices.find_by(day: Date.today)
      @practice = @classroom.practices.create(
        day: Date.today,
        qr_code_string: SecureRandom.hex(64)
      )
      render json: @practice
    else
      render json: @classroom.practices.find_by(day: Date.today)
    end
  end

  def verification
    if @practice.verify_qr_code(verification_params)
      current_user.add_practice(@practice)
      render json: current_user, include: ['practices']
    else
      render json: { message: "Unauthorized" }, status: 401
    end
  end

  private
  def set_classroom
    @classroom = current_user.classrooms.find(params[:classroom_id])
  end

  def set_practice
    @practice = @classroom.practices.find(params[:practice_id])
  end

  def verification_params
    params.require(:qr_code_string)
  end
end
