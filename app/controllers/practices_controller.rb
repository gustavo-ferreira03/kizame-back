class PracticesController < ApplicationController
  before_action :verify_authenticated
  before_action :set_classroom
  before_action :verify_instructor, only: :create
  before_action :verify_student, only: :verify_qr_code
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
    if @practice.qr_code_string == verification_params
      current_user.practice_attendencies.create(practice_id: @practice.id)
      render json: current_user, include: ['practices']
    else
      render json: { message: "Wrong QR Code" }, status: 401
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
