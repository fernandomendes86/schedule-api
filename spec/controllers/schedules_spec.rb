require "rails_helper"
describe SchedulesController, type: :controller do
  
  describe "Schedules - Actions" do

    let(:room) { Room.create!(
        description: "Room Example", 
        start_time: Time.zone.local(2020,1,1,9,0), 
        end_time: Time.zone.local(2020,1,1,18,0)
      ) 
    }

    let(:schedule) { Schedule.find(1) rescue Schedule.create!(
      room: room,
      subject: "Subject Example",
      start_at: Time.zone.local(2020,1,2,10,0),
      end_at: Time.zone.local(2020,1,2,12,0)
      ) 
    }

    it "GET INDEX and return :ok" do
      get :index
      expect(response).to have_http_status(:ok)
    end

    it "GET SHOW /schedules/:id" do
      get :show, params: {id: schedule.id}
      response_body = JSON.parse(response.body, symbolize_names: true)
      expect(response_body[:id]).to eq(schedule.id) 
    end

    it "POST CREATE and return :created" do
      start_at = Time.zone.local(2022,01,14,10,0)
      end_at = start_at+2.hour
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
      start_at = Time.zone.local(2022,01,14,10,0)
      end_at = start_at+2.hour
      put :update, params: { id: schedule.id, schedule: { 
        subject: "Schedule Update", start_at: start_at, end_at: end_at, room_id: room.id } }
      expect(response).to have_http_status(:ok)
    end

    it "DELETE DESTROY and return :no_content  " do
      put :destroy, params: { id: schedule.id }
      expect(response).to have_http_status(:no_content)
    end
  end

  describe "Schedules - Validations" do
    let(:room) { Room.create!(
        description: "Room Example", 
        start_time: Time.zone.local(2020,1,1,9,0), 
        end_time: Time.zone.local(2020,1,1,18,0)
      ) 
    }

    it "POST - Saturday and return :unprocessable_entity" do
      start_at = Time.zone.local(2022,01,15,10,0)
      end_at = start_at+2.hour
      
      post :create, params: { schedule: { 
        subject: "Subject", start_at: start_at, end_at: end_at, room_id: room.id } }
      message = JSON.parse(response.body).fetch("base")
      expect(message).to include(/Saturday/)
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "POST - Sunday and return :unprocessable_entity" do
      start_at = Time.zone.local(2022,01,16,10,0)
      end_at = start_at+2.hour
      
      post :create, params: { schedule: { 
        subject: "Subject", start_at: start_at, end_at: end_at, room_id: room.id } }
      message = JSON.parse(response.body).fetch("base")
      expect(message).to include(/Sunday/)
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "POST - Input with valid time range end return :created" do
      start_at = Time.zone.local(2020,1,1,14,0)
      end_at = start_at+1.hour

      post :create, params: { schedule: { 
        subject: "Subject 1", start_at: start_at, end_at: end_at, room_id: room.id } 
      }
      expect(response).to have_http_status(:created)

      start_at = Time.zone.local(2020,1,1,15,0)
      end_at = start_at+1.hour
      
      post :create, params: { schedule: { 
        subject: "Subject 1", start_at: start_at, end_at: end_at, room_id: room.id } 
      }
      expect(response).to have_http_status(:created)

      start_at = Time.zone.local(2020,1,1,13,0)
      end_at = start_at+1.hour
      
      post :create, params: { schedule: { 
        subject: "Subject 1", start_at: start_at, end_at: end_at, room_id: room.id } 
      }
      expect(response).to have_http_status(:created)
    end

    it "POST - Input with invalid time range end return :unprocessable_entity" do
      start_at = Time.zone.local(2020,1,1,14,0)
      end_at = start_at+1.hour

      post :create, params: { schedule: { 
        subject: "Subject 1", start_at: start_at, end_at: end_at, room_id: room.id } 
      }
      expect(response).to have_http_status(:created)

      start_at = Time.zone.local(2020,1,1,14,2)
      end_at = start_at+1.hour
      
      post :create, params: { schedule: { 
        subject: "Subject 1", start_at: start_at, end_at: end_at, room_id: room.id } 
      }
      expect(response).to have_http_status(:unprocessable_entity)

      start_at = Time.zone.local(2020,1,1,13,2)
      end_at = start_at+1.hour
      
      post :create, params: { schedule: { 
        subject: "Subject 1", start_at: start_at, end_at: end_at, room_id: room.id } 
      }
      expect(response).to have_http_status(:unprocessable_entity)

    end

  end
  
end
