require 'rails_helper'

RSpec.describe "PetControllers", type: :request do
  describe "GET" do
    it "returns http success" do
      get "/pet"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET by id" do
    it "returns http success" do
      pet = create(:pet)
      get "/pet/#{pet.id}"
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new pet" do
        cliente = create(:cliente)
        expect {
          post "/pet", params: { pet: FactoryBot.attributes_for(:pet), cliente_id: cliente.id }
        }.to change(Pet, :count).by(1)
      end

      it "returns a 201 status code" do
        cliente = create(:cliente)
        post "/pet", params: { pet: FactoryBot.attributes_for(:pet), cliente_id: cliente.id }
        expect(response).to have_http_status(201)
      end

      it "returns the created pet as JSON" do
        cliente = create(:cliente)
        pet_data = FactoryBot.attributes_for(:pet)
        post "/pet", params: { pet: pet_data, cliente_id: cliente.id }
        json = JSON.parse(response.body)
        expect(json["nome"]).to eq(pet_data[:nome])
        expect(json["raca"]).to eq(pet_data[:raca])
        expect(json["especie"]).to eq(pet_data[:especie])
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        { nome: "Novo nome" }
      }

      it "updates the requested pet" do
        cliente = create(:cliente)
        pet = create(:pet)
        put "/pet/#{pet.id}", params: { pet: new_attributes, cliente_id: cliente.id }
        pet.reload
        expect(pet.nome).to eq(new_attributes[:nome])
      end

      it "returns a 200 status code" do
        cliente = create(:cliente)
        pet = create(:pet)
        put "/pet/#{pet.id}", params: { pet: new_attributes, cliente_id: cliente.id }
        expect(response).to have_http_status(200)
      end

      it "returns the updated pet as JSON" do
        cliente = create(:cliente)
        pet = create(:pet)
        put "/pet/#{pet.id}", params: { pet: new_attributes, cliente_id: cliente.id }
        json = JSON.parse(response.body)
        expect(json["nome"]).to eq(new_attributes[:nome])
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested pet" do
      pet = create(:pet)
      expect {
        delete "/pet/#{pet.id}"
      }.to change(Pet, :count).by(-1)
    end

    it "returns a 204 status code" do
      pet = create(:pet)
      delete "/pet/#{pet.id}"
      expect(response).to have_http_status(204)
    end
  end

end