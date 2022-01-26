RSpec.describe "Room", :type => :request do

  describe "Schedules - Actions" do

    it "REQUESTS POST :created " do
      #headers = { "ACCEPT" => "application/json" }
      post "/rooms", :params => 
                    { :room => {
                            :description => "My Widget",
                            start_time: Time.zone.local(2020,1,1,9,0), 
                            end_time: Time.zone.local(2020,1,1,18,0)} }, 
                            :headers => headers

      expect(response.content_type).to eq("application/vnd.api+json; charset=utf-8")
      expect(response).to have_http_status(:created)
    end
  end
end
