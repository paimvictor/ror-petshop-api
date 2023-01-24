require 'rails_helper'

RSpec.describe "ServiceControllers", type: :request do
  let (:service) { create(:service) }
  let (:pet) { create(:pet) }

  describe "GET" do
    it "returns http success" do
      get "/service"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET by id" do
    it "returns http success" do
      get "/service/#{service.id}"
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new service" do
        expect {
          post "/service", params: { service: FactoryBot.attributes_for(:service), pet_id: pet.id }
        }.to change(Service, :count).by(1)
      end

      it "returns a 201 status code" do
        post "/service", params: { service: FactoryBot.attributes_for(:service), pet_id: pet.id }
        expect(response).to have_http_status(201)
      end

      it "returns the created service as JSON" do
        service_data = FactoryBot.attributes_for(:service)
        post "/service", params: { service: service_data, pet_id: pet.id }
        json = JSON.parse(response.body)
        expect(json["title"]).to eq(service_data[:title])
      end
    end

    context "with invalid params" do
      it "returns a 422 status code" do
        post "/service", params: { service: { title: nil }, pet_id: pet.id }
        expect(response).to have_http_status(422)
      end

      it "returns the errors as JSON" do
        post "/service", params: { service: { title: nil }, pet_id: pet.id }
        json = JSON.parse(response.body)
        expect(json['title']).to include("can't be blank")
        expect(json['price']).to include("can't be blank")
        expect(json['scheduled_date']).to include("can't be blank")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      it "updates the requested service" do
        put "/service/#{service.id}", params: { service: { title: "New title" } }
        service.reload
        expect(service.title).to eq("New title")
      end

      it "returns a 200 status code" do
        put "/service/#{service.id}", params: { service: { title: "New title" } }
        expect(response).to have_http_status(200)
      end

      it "returns the updated service as JSON" do
        put "/service/#{service.id}", params: { service: { title: "New title" } }
        json = JSON.parse(response.body)
        expect(json["title"]).to eq("New title")
      end
    end

    context "with invalid params" do
      it "returns a 422 status code" do
        put "/service/#{service.id}", params: { service: { title: nil } }
        expect(response).to have_http_status(422)
      end

      it "returns the errors as JSON" do
        put "/service/#{service.id}", params: { service: { title: nil } }
        json = JSON.parse(response.body)
        expect(json['title']).to include("can't be blank")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested service" do
      new_service = create(:service)
      expect {
        delete "/service/#{new_service.id}"
      }.to change(Service, :count).by(-1)
    end

    it "returns a 204 status code" do
      new_service = create(:service)
      delete "/service/#{new_service.id}"
      expect(response).to have_http_status(204)
    end
  end

  describe "GET #search" do
    it "returns http success" do
      get "/service/search?scheduled_date=#{service.scheduled_date}"
      expect(response).to have_http_status(:success)
    end
  end
end
