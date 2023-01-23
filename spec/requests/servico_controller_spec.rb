require 'rails_helper'

RSpec.describe "ServicoControllers", type: :request do
  describe "GET" do
    it "returns http success" do
      get "/servico"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET by id" do
    it "returns http success" do
      servico = create(:servico)
      get "/servico/#{servico.id}"
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new servico" do
        pet = create(:pet)
        expect {
          post "/servico", params: { servico: FactoryBot.attributes_for(:servico), pet_id: pet.id }
        }.to change(Servico, :count).by(1)
      end

      it "returns a 201 status code" do
        pet = create(:pet)
        servico_data = FactoryBot.attributes_for(:servico)
        post "/servico", params: { servico: FactoryBot.attributes_for(:servico), pet_id: pet.id }
        expect(response).to have_http_status(201)
      end

      it "returns the created servico as JSON" do
        pet = create(:pet)
        servico_data = FactoryBot.attributes_for(:servico)
        post "/servico", params: { servico: servico_data, pet_id: pet.id }
        json = JSON.parse(response.body)
        expect(json["nome"]).to eq(servico_data[:nome])
        expect(json["descricao"]).to eq(servico_data[:descricao])
        expect(json["preco"]).to eq(servico_data[:preco])
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      it "updates the requested servico" do
        servico = create(:servico)
        put "/servico/#{servico.id}", params: { servico: { titulo: "Novo titulo" } }
        servico.reload
        expect(servico.titulo).to eq("Novo titulo")
      end

      it "returns a 200 status code" do
        servico = create(:servico)
        put "/servico/#{servico.id}", params: { servico: { titulo: "Novo titulo" } }
        expect(response).to have_http_status(200)
      end

      it "returns the updated servico as JSON" do
        servico = create(:servico)
        put "/servico/#{servico.id}", params: { servico: { titulo: "Novo titulo" } }
        json = JSON.parse(response.body)
        expect(json["titulo"]).to eq("Novo titulo")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested servico" do
      servico = create(:servico)
      expect {
        delete "/servico/#{servico.id}"
      }.to change(Servico, :count).by(-1)
    end

    it "returns a 204 status code" do
      servico = create(:servico)
      delete "/servico/#{servico.id}"
      expect(response).to have_http_status(204)
    end
  end
end
