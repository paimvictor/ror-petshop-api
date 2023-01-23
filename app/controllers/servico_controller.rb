class ServicoController < ApplicationController
  def index
    @servicos = Servico.all
    render json: @servicos, status: :ok
  end

  def show
    @servico = Servico.find(params[:id])
    render json: @servico, status: :ok
  end

  def create
    @servico = Servico.new(servico_params)

    if @servico.save
      render json: @servico, status: :created
    else
      render json: @servico.errors, status: :unprocessable_entity
    end
  end

  def update
    @servico = Servico.find(params[:id])

    if @servico.update(servico_params)
      render json: @servico, status: :ok
    else
      render json: @servico.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @servico = Servico.find(params[:id])
    @servico.destroy

    render json: @servico, status: :no_content
  end

  def search
    @servicos = Servico.where(data_agendamento: params[:data_agendamento])
    render json: @servicos, status: :ok
  end

  private
    def servico_params
      params.require(:servico).permit(:titulo, :preco, :data_agendamento)
    end
end
