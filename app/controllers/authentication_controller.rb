class AuthenticationController < ApplicationController
  def login
    @user = User.find_by(email: login_params[:email])

    if !@user.nil? && @user.authenticate(login_params[:password])
      @token = JsonWebToken::Base.encode( {user_id: @user.id} )
      render json: { token: @token }, status: 200
    else
      render json: { message: "Authentication error." }
    end
  end

  def signup
    @user = User.new(signup_user_params)
    @modality = @user.user_modality.build(modality_id: modality_id)

    User.transaction do
      @user.save!
      @modality.save!
      render json: @user, status: :created
    rescue ActiveRecord::RecordInvalid => invalid
      render json: invalid.record.errors, status: :unprocessable_entity
    end
  end

  private
    def signup_user_params
      params.require(:user).permit(:name, :last_name, :email, :password, :password_confirmation, :profile_picture)
    end

    def modality_id
      params.require(:modality).permit(:id)[:id]
    end

    def signup_address_params
      params.require(:address).permit(:street, :number, :city, :state, :zip_code)
    end
    
    def login_params
      params.require(:user).permit(:email, :password)
    end
end
