class ClienteController < ApplicationController
  def index
    @clientes = Cliente.all
    render json: @clientes, status: :ok
  end

  def show
    @cliente = Cliente.find(params[:id])
    render json: @cliente, status: :ok
  end

  def create
    @cliente = Cliente.new(cliente_params)

    if @cliente.save
      render json: @cliente, status: :created
    else
      render json: @cliente.errors, status: :unprocessable_entity
    end
  end

  def update
    @cliente = Cliente.find(params[:id])

    if @cliente.update(cliente_params)
      render json: @cliente, status: :ok
    else
      render json: @cliente.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @cliente = Cliente.find(params[:id])
    @cliente.destroy

    render json: @cliente, status: :no_content
  end

  private
    def cliente_params
      params.require(:cliente).permit(:nome, :email, :telefone)
    end
end
