require 'rails_helper'

RSpec.describe "ServicoControllers", type: :request do
  before do
    @servico = create(:servico)
    @pet = create(:pet)
  end

  describe "GET" do
    it "returns http success" do
      get "/servico"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET by id" do
    it "returns http success" do
      get "/servico/#{@servico.id}"
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new servico" do
        expect {
          post "/servico", params: { servico: FactoryBot.attributes_for(:servico), pet_id: @pet.id }
        }.to change(Servico, :count).by(1)
      end

      it "returns a 201 status code" do
        post "/servico", params: { servico: FactoryBot.attributes_for(:servico), pet_id: @pet.id }
        expect(response).to have_http_status(201)
      end

      it "returns the created servico as JSON" do
        servico_data = FactoryBot.attributes_for(:servico)
        post "/servico", params: { servico: servico_data, pet_id: @pet.id }
        json = JSON.parse(response.body)
        expect(json["titulo"]).to eq(servico_data[:titulo])
      end
    end

    context "with invalid params" do
      it "returns a 422 status code" do
        post "/servico", params: { servico: { titulo: nil }, pet_id: @pet.id }
        expect(response).to have_http_status(422)
      end

      it "returns the errors as JSON" do
        post "/servico", params: { servico: { titulo: nil }, pet_id: @pet.id }
        json = JSON.parse(response.body)
        expect(json['titulo']).to include("can't be blank")
        expect(json['preco']).to include("can't be blank")
        expect(json['data_agendamento']).to include("can't be blank")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      it "updates the requested servico" do
        put "/servico/#{@servico.id}", params: { servico: { titulo: "Novo titulo" } }
        @servico.reload
        expect(@servico.titulo).to eq("Novo titulo")
      end

      it "returns a 200 status code" do
        put "/servico/#{@servico.id}", params: { servico: { titulo: "Novo titulo" } }
        expect(response).to have_http_status(200)
      end

      it "returns the updated servico as JSON" do
        put "/servico/#{@servico.id}", params: { servico: { titulo: "Novo titulo" } }
        json = JSON.parse(response.body)
        expect(json["titulo"]).to eq("Novo titulo")
      end
    end

    context "with invalid params" do
      it "returns a 422 status code" do
        put "/servico/#{@servico.id}", params: { servico: { titulo: nil } }
        expect(response).to have_http_status(422)
      end

      it "returns the errors as JSON" do
        put "/servico/#{@servico.id}", params: { servico: { titulo: nil } }
        json = JSON.parse(response.body)
        expect(json['titulo']).to include("can't be blank")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested servico" do
      expect {
        delete "/servico/#{@servico.id}"
      }.to change(Servico, :count).by(-1)
    end

    it "returns a 204 status code" do
      delete "/servico/#{@servico.id}"
      expect(response).to have_http_status(204)
    end
  end

  describe "GET #search" do
    it "returns http success" do
      get "/servico/search?data_agendamento=#{@servico.data_agendamento}"
      expect(response).to have_http_status(:success)
    end
  end
end
