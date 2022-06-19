class ClassroomsController < ApplicationController
  before_action :set_classroom, only: [:show, :update, :destroy, :join_classroom, :leave_classroom]
  before_action :verify_authenticated
  before_action :verify_instructor, only: [:create, :update]
  before_action :verify_admin, only: [:destroy]

  # GET /classrooms
  def index
    @classrooms = current_user.admin? ? 
      Classroom.all : available_classrooms

    render json: @classrooms
  end

  # GET /classrooms/1
  def show
    render json: @classroom
  end

  # POST /classrooms
  def create
    @classroom = Classroom.new(classroom_params)
    @schedule = @classroom.build_schedule(schedule_params)
    @modality = @classroom.build_classroom_modality(modality_id: user_modality.id)

    Classroom.transaction do
      @classroom.save!
      @schedule.save!
      @modality.save!
      @classroom.members.append(current_user)
      render json: @classroom, status: :created, location: @classroom
    rescue ActiveRecord::RecordInvalid => invalid
      render json: invalid.record.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /classrooms/1
  def update
    if @classroom.update(classroom_params)
      render json: @classroom
    else
      render json: @classroom.errors, status: :unprocessable_entity
    end
  end

  # DELETE /classrooms/1
  def destroy
    @classroom.destroy
  end

  # GET /my_classrooms
  def my_classrooms
    @classrooms = current_user.classrooms

    if current_user.instructor? || current_user.admin?
      render json: @classrooms, include: ['students']
    else
      render json: @classrooms, include: []
    end
  end

  # POST /classrooms/1/join
  def join_classroom
    if @classroom.add_user(current_user)
      render json: current_user, include: ['classrooms', 'classrooms.schedule']
    else
      render json: { message: "Usuário já está na turma" }, status: 403
    end
  end

  # POST /my_classrooms/1/leave
  def leave_classroom
    if @classroom.remove_user(current_user)
      render json: current_user
    else
      render json: { message: "Usuário não está na turma" }, status: 400
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_classroom
      @classroom = current_user.admin? ? 
        Classroom.find(params[:id]) : user_modality.classrooms.find_by(id: params[:id])
    end

    def user_modality
      current_user.modality
    end

    def available_classrooms
      current_user.available_classrooms
    end

    # Only allow a list of trusted parameters through.
    def classroom_params
      params.require(:classroom).permit(:name)
    end

    def schedule_params
      params.require(:schedule).permit(:from_weekday, :to_weekday, :from_time, :to_time)
    end
end
