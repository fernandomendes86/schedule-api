require "rails_helper"
describe RoomsController, type: :controller do
  
  describe "GET index" do
    it "returns a 200" do
      get :index
      expect(response).to have_http_status(:ok)
      expect(response.status).to eql(200)
    end

  end
  
end
