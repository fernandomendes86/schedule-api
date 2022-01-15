require "rails_helper"
describe RoomsController, type: :controller do
  
  describe "Rooms - Actions" do

    let(:room) { Room.find(1) rescue Room.create }

    it "GET INDEX and return :ok" do
      get :index
      expect(response).to have_http_status(:ok)
    end

    it "GET SHOW /rooms/:id" do
      get :show, params: {id: room.id}
      response_body = JSON.parse(response.body, symbolize_names: true)
      expect(response_body[:id]).to eq(room.id) 
    end

    it "POST CREATE and return :created" do
      start_time = Time.now
      end_time = Time.now+8.hour
      post :create, params: { room: { 
        description: "Room Teste", start_time: start_time, end_time: end_time } }
      expect(response.content_type).to eq("application/json; charset=utf-8")
      expect(response).to have_http_status(:created)
    end

    it "PATCH UPDATE and return :ok" do
      patch :update, params: { id: room.id, room: { description: "Room Update"} }
      expect(response).to have_http_status(:ok)
    end

    it "PUT UPDATE and return :ok" do
      start_time = Time.now
      end_time = Time.now+5.hour
      put :update, params: { id: room.id, room: { 
        description: "Room Update", start_time: start_time, end_time: end_time } }
      expect(response).to have_http_status(:ok)
    end

    it "DELETE DESTROY and return No Content  " do
      put :destroy, params: { id: room.id }
      expect(response).to have_http_status(:no_content)
    end
    
  end
  
end
