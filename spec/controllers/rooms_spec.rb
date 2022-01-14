require "rails_helper"
describe RoomsController, type: :controller do
  
  describe "Rooms HTTP Verb - Path" do

    let(:room) { Room.find(1) }

    it "GET INDEX and return :ok" do
      get :index
      expect(response).to have_http_status(:ok)
    end

    it "GET SHOW /rooms/:id" do
      get :show, params: {id: room.id}
      response_body = JSON.parse(response.body, symbolize_names: true)
      expect(response_body[:id]).to eql(room.id) 
    end

  end
  
end
