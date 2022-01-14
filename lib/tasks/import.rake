namespace :import do
  desc "Setup app"
  task add_rooms: :environment do
    puts "Creating rooms..."
    (1..4).each do |i|
      Room.create!(
        description: "Room #{i}", 
        start_time: Time.zone.local(2020,1,1,9,0), 
        end_time: Time.zone.local(2020,1,1,18,0)
      )
    end
    puts "Rooms created successfully!"
  end

end
