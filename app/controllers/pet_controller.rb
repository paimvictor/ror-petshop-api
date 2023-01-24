class PetController < ApplicationController
  def index
    @pets = Pet.all
    render json: @pets, status: :ok
  end

  def show
    @pet = Pet.find(params[:id])
    render json: @pet, status: :ok
  end

  def create
    @client = Client.find(params[:client_id])
    @pet = @client.pets.build(pet_params)

    if @pet.save
      render json: @pet, status: :created
    else
      render json: @pet.errors, status: :unprocessable_entity
    end
  end

  def update
    @pet = Pet.find(params[:id])

    if @pet.update(pet_params)
      render json: @pet, status: :ok
    else
      render json: @pet.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @pet = Pet.find(params[:id])
    @pet.destroy

    render json: @pet, status: :no_content
  end

  private
    def pet_params
      params.require(:pet).permit(:name, :species, :breed)
    end
end
