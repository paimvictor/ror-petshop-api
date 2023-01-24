require 'rails_helper'

RSpec.describe "ClientControllers", type: :request do
  before do
    @client = create(:client)
  end
  describe "GET" do
    it "returns http success" do
      get "/client"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET by id" do
    it "returns http success" do
      get "/client/#{@client.id}"
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new client" do
        expect {
          post "/client", params: { client: FactoryBot.attributes_for(:client) }
        }.to change(Client, :count).by(1)
      end

      it "returns a 201 status code" do
        post "/client", params: { client: FactoryBot.attributes_for(:client) }
        expect(response).to have_http_status(201)
      end

      it "returns the created client as JSON" do
        client_data = FactoryBot.attributes_for(:client)
        post "/client", params: { client: client_data }
        json = JSON.parse(response.body)
        expect(json["name"]).to eq(client_data[:name])
        expect(json["email"]).to eq(client_data[:email])
        expect(json["phone"]).to eq(client_data[:phone])
      end
    end

    context "with invalid params" do
      it "returns a 422 status code" do
        post "/client", params: { client: { name: nil } }
        expect(response).to have_http_status(422)
      end

      it "returns the errors as JSON" do
        post "/client", params: { client: { name: nil } }
        json = JSON.parse(response.body)
        expect(json["name"]).to include("can't be blank")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        { name: "New name" }
      }

      it "updates the requested client" do
        put "/client/#{@client.id}", params: { client: new_attributes }
        @client.reload
        expect(@client.name).to eq(new_attributes[:name])
      end

      it "returns a 200 status code" do
        put "/client/#{@client.id}", params: { client: new_attributes }
        expect(response).to have_http_status(200)
      end

      it "returns the updated client as JSON" do
        put "/client/#{@client.id}", params: { client: new_attributes }
        json = JSON.parse(response.body)
        expect(json["name"]).to eq(new_attributes[:name])
      end
    end

    context "with invalid params" do
      it "returns a 422 status code" do
        put "/client/#{@client.id}", params: { client: { name: nil } }
        expect(response).to have_http_status(422)
      end

      it "returns the errors as JSON" do
        put "/client/#{@client.id}", params: { client: { name: nil } }
        json = JSON.parse(response.body)
        expect(json["name"]).to include("can't be blank")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested client" do
      expect {
        delete "/client/#{@client.id}"
      }.to change(Client, :count).by(-1)
    end

    it "returns a 204 status code" do
      delete "/client/#{@client.id}"
      expect(response).to have_http_status(204)
    end
  end
end
