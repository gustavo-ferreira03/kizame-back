class UsersController < ApplicationController
  before_action :verify_authenticated
  before_action :verify_admin, except: [:profile, :update_profile]
  before_action :set_user, only: [:show, :update, :destroy]
  before_action :set_current_user, only: [:show_profile, :update_profile]

  # GET /users
  def index
    @users = User.all

    render json: @users
  end

  # GET /users/1
  def show
    render json: @user
  end

  # POST /users
  def create_instructor
    @user = User.new(user_params)
    @user.role = 1
    @modality = @user.build_user_modality(modality_id: modality_id)

    User.transaction do
      @user.save!
      @modality.save!
      render json: @user, status: :created
    rescue ActiveRecord::RecordInvalid => invalid
      render json: invalid.record.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  # GET /profile
  def show_profile
    render json: @user
  end

  def update_profile
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    def set_current_user
      @user = current_user
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :last_name, :email, :password, :password_confirmation, :profile_picture)
    end

    def modality_id
      params.require(:modality).permit(:id)[:id]
    end
end
