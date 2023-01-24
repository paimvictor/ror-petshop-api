require 'rails_helper'

RSpec.describe "ClienteControllers", type: :request do
  describe "GET" do
    it "returns http success" do
      get "/cliente"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET by id" do
    it "returns http success" do
      cliente = create(:cliente)
      get "/cliente/#{cliente.id}"
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new cliente" do
        expect {
          post "/cliente", params: { cliente: FactoryBot.attributes_for(:cliente) }
        }.to change(Cliente, :count).by(1)
      end

      it "returns a 201 status code" do
        post "/cliente", params: { cliente: FactoryBot.attributes_for(:cliente) }
        expect(response).to have_http_status(201)
      end

      it "returns the created cliente as JSON" do
        cliente_data = FactoryBot.attributes_for(:cliente)
        post "/cliente", params: { cliente: cliente_data }
        json = JSON.parse(response.body)
        expect(json["nome"]).to eq(cliente_data[:nome])
        expect(json["email"]).to eq(cliente_data[:email])
        expect(json["telefone"]).to eq(cliente_data[:telefone])
      end
    end

    context "with invalid params" do
      it "returns a 422 status code" do
        post "/cliente", params: { cliente: { nome: nil } }
        expect(response).to have_http_status(422)
      end

      it "returns the errors as JSON" do
        post "/cliente", params: { cliente: { nome: nil } }
        json = JSON.parse(response.body)
        expect(json["nome"]).to include("can't be blank")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        { nome: "Novo Nome" }
      }

      it "updates the requested cliente" do
        cliente = create(:cliente)
        put "/cliente/#{cliente.id}", params: { cliente: new_attributes }
        cliente.reload
        expect(cliente.nome).to eq(new_attributes[:nome])
      end

      it "returns a 200 status code" do
        cliente = create(:cliente)
        put "/cliente/#{cliente.id}", params: { cliente: new_attributes }
        expect(response).to have_http_status(200)
      end

      it "returns the updated cliente as JSON" do
        cliente = create(:cliente)
        put "/cliente/#{cliente.id}", params: { cliente: new_attributes }
        json = JSON.parse(response.body)
        expect(json["nome"]).to eq(new_attributes[:nome])
      end
    end

    context "with invalid params" do
      it "returns a 422 status code" do
        cliente = create(:cliente)
        put "/cliente/#{cliente.id}", params: { cliente: { nome: nil } }
        expect(response).to have_http_status(422)
      end

      it "returns the errors as JSON" do
        cliente = create(:cliente)
        put "/cliente/#{cliente.id}", params: { cliente: { nome: nil } }
        json = JSON.parse(response.body)
        expect(json["nome"]).to include("can't be blank")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested cliente" do
      cliente = create(:cliente)
      expect {
        delete "/cliente/#{cliente.id}"
      }.to change(Cliente, :count).by(-1)
    end

    it "returns a 204 status code" do
      cliente = create(:cliente)
      delete "/cliente/#{cliente.id}"
      expect(response).to have_http_status(204)
    end
  end
end
