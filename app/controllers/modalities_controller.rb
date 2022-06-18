class ModalitiesController < ApplicationController
  before_action :verify_authenticated, except: :index
  before_action :verify_admin, except: :index

  def index
    @modalities = Modality.all

    render json: @modalities
  end

  def create
    @modality = Modality.new(modality_params)

    if @modality.save
      render json: @modality, status: 201
    else
      render json: @modality.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @modality.destroy
  end

  private
    def set_modality
      @modality = Modality.find(params[:id])
    end

    def modality_params
      params.require(:modality).permit(:name)
    end
end
