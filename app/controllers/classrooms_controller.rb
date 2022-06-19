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
    @classroom.build_classroom_modality(modality_id: user_modality.id)
    
    if @classroom.save
      @classroom.members.append(current_user)
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

  # GET /my_classrooms
  def my_classrooms
    @classrooms = current_user.classrooms

    render json: @classrooms
  end

  # POST /classrooms/1/join
  def join_classroom
    if @classroom.add_user(current_user)
      render json: current_user
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
        Classroom.find(params[:id]) : available_classrooms.find(params[:id])
    end

    def user_modality
      current_user.modality
    end

    def available_classrooms
      user_modality.classrooms
    end

    def verify_user_not_in_classroom

    end

    # Only allow a list of trusted parameters through.
    def classroom_params
      params.require(:classroom).permit(:name)
    end
end
