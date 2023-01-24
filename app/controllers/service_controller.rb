class ServiceController < ApplicationController
  def index
    @services = Service.all
    render json: @services, status: :ok
  end

  def show
    @service = Service.find(params[:id])
    render json: @service, status: :ok
  end

  def create
    @pet = Pet.find(params[:pet_id])
    @service = @pet.services.build(service_params)

    if @service.save
      render json: @service, status: :created
    else
      render json: @service.errors, status: :unprocessable_entity
    end
  end

  def update
    @service = Service.find(params[:id])

    if @service.update(service_params)
      render json: @service, status: :ok
    else
      render json: @service.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @service = Service.find(params[:id])
    @service.destroy

    render json: @service, status: :no_content
  end

  def search
    @services = Service.where(scheduled_date: params[:scheduled_date])
    render json: @services, status: :ok
  end

  private
    def service_params
      params.require(:service).permit(:title, :price, :scheduled_date)
    end
end
