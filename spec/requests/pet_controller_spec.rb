require 'rails_helper'

RSpec.describe "PetControllers", type: :request do
  let (:pet) { create(:pet) }
  let (:client) { create(:client) }

  describe "GET" do
    it "returns http success" do
      get "/pet"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET by id" do
    it "returns http success" do
      get "/pet/#{pet.id}"
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new pet" do
        expect {
          post "/pet", params: { pet: FactoryBot.attributes_for(:pet), client_id: client.id }
        }.to change(Pet, :count).by(1)
      end

      it "returns a 201 status code" do
        post "/pet", params: { pet: FactoryBot.attributes_for(:pet), client_id: client.id }
        expect(response).to have_http_status(201)
      end

      it "returns the created pet as JSON" do
        pet_data = FactoryBot.attributes_for(:pet)
        post "/pet", params: { pet: pet_data, client_id: client.id }
        json = JSON.parse(response.body)
        expect(json["name"]).to eq(pet_data[:name])
        expect(json["breed"]).to eq(pet_data[:breed])
        expect(json["species"]).to eq(pet_data[:species])
      end
    end

    context "with invalid params" do
      it "returns a 422 status code" do
        post "/pet", params: { pet: { name: nil }, client_id: client.id }
        expect(response).to have_http_status(422)
      end

      it "returns the errors as JSON" do
        post "/pet", params: { pet: { name: nil }, client_id: client.id }
        json = JSON.parse(response.body)
        expect(json["name"]).to include(I18n.t("errors.messages.blank"))
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        { name: "New name" }
      }

      it "updates the requested pet" do
        put "/pet/#{pet.id}", params: { pet: new_attributes, client_id: client.id }
        pet.reload
        expect(pet.name).to eq(new_attributes[:name])
      end

      it "returns a 200 status code" do
        put "/pet/#{pet.id}", params: { pet: new_attributes, client_id: client.id }
        expect(response).to have_http_status(200)
      end

      it "returns the updated pet as JSON" do
        put "/pet/#{pet.id}", params: { pet: new_attributes, client_id: client.id }
        json = JSON.parse(response.body)
        expect(json["name"]).to eq(new_attributes[:name])
      end
    end

    context "with invalid params" do
      it "returns a 422 status code" do
        put "/pet/#{pet.id}", params: { pet: { name: nil }, client_id: client.id }
        expect(response).to have_http_status(422)
      end

      it "returns the errors as JSON" do
        put "/pet/#{pet.id}", params: { pet: { name: nil }, client_id: client.id }
        json = JSON.parse(response.body)
        expect(json["name"]).to include(I18n.t("errors.messages.blank"))
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested pet" do
      new_pet = create(:pet)
      expect {
        delete "/pet/#{new_pet.id}"
      }.to change(Pet, :count).by(-1)
    end

    it "returns a 204 status code" do
      new_pet = create(:pet)
      delete "/pet/#{new_pet.id}"
      expect(response).to have_http_status(204)
    end
  end

end
