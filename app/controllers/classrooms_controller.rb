class ClassroomsController < ApplicationController
  before_action :set_classroom, only: [:show, :update, :destroy]
  before_action :verify_authenticated
  before_action :verify_instructor, only: [:create, :update]
  before_action :verify_admin, only: [:destroy]

  # GET /classrooms
  def index
    @classrooms = current_user.admin? ? 
      Classroom.all : user_classrooms

    render json: @classrooms
  end

  # GET /classrooms/1
  def show
    render json: @classroom
  end

  # POST /classrooms
  def create
    @classroom = current_user.classrooms.build(classroom_params)
    @classroom.classroom_modality.modality_id = user_modality

    if @classroom.save
      render json: @classroom, status: :created, location: @classroom
    else
      render json: @classroom.errors, status: :unprocessable_entity
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_classroom
      @classroom = current_user.admin? ? 
        Classroom.find(params[:id]) : user_classrooms.find(params[:id])
    end

    def user_classrooms
      Classroom.includes(:classroom_modality).where(
        classroom_modality: { modality_id: current_user.modality.id }
      )
    end

    # Only allow a list of trusted parameters through.
    def classroom_params
      params.require(:classroom).permit(:name)
    end
end
