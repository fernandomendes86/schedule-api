require "rails_helper"
describe SchedulesController, type: :controller do
  
  describe "Schedules - Actions" do

    let(:room) { Room.find(1) rescue Room.create }
    let(:schedule) { Schedule.find(1) rescue Schedule.create(room: room) }

    it "GET INDEX and return :ok" do
      get :index
      expect(response).to have_http_status(:ok)
    end

    it "GET SHOW /schedules/1" do
      get :show, params: {id: schedule.id}
      response_body = JSON.parse(response.body, symbolize_names: true)
      expect(response_body[:id]).to eq(schedule.id) 
    end

    it "POST CREATE and return :created" do
      start_at = Time.now
      end_at = Time.now+2.hour
      post :create, params: { schedule: { 
        subject: "Subject", start_at: start_at, end_at: end_at, room_id: room.id } }
      expect(response.content_type).to eq("application/json; charset=utf-8")
      expect(response).to have_http_status(:created)
    end

    it "PATCH UPDATE and return :ok" do
      patch :update, params: { id: schedule.id, schedule: { subject: "Subject Update"} }
      expect(response).to have_http_status(:ok)
    end

    it "PUT UPDATE and return :ok" do
      start_at = Time.now
      end_at = Time.now+2.hour
      put :update, params: { id: schedule.id, schedule: { 
        subject: "Schedule Update", start_at: start_at, end_at: end_at, room_id: room.id } }
      expect(response).to have_http_status(:ok)
    end

    it "DELETE DESTROY and return No Content  " do
      put :destroy, params: { id: schedule.id }
      expect(response).to have_http_status(:no_content)
    end
    
  end
  
end
