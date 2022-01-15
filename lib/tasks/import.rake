namespace :import do
  desc "Setup app"
  task add_rooms_and_schedule: :environment do
    puts "Creating rooms..."
    (1..4).each do |i|
      Room.create!(
        description: "Room #{i}", 
        start_time: Time.zone.local(2020,1,1,9,0), 
        end_time: Time.zone.local(2020,1,1,18,0)
      )
    end
    puts "Rooms created successfully!"

    puts "Creating schedule..."
    Schedule.create!(
      room: Room.first,
      subject: "Subject Example",
      start_at: Time.zone.local(2020,1,2,11,0),
      end_at: Time.zone.local(2020,1,2,12,0)
    ) 

    Schedule.create!(
      room: Room.first,
      subject: "Subject Example",
      start_at: Time.zone.local(2020,1,2,12,0),
      end_at: Time.zone.local(2020,1,2,13,0)
    ) 

    Schedule.create!(
      room: Room.all.sample,
      subject: "Subject Example",
      start_at: Time.zone.local(2020,1,2,15,0),
      end_at: Time.zone.local(2020,1,2,16,0)
    ) 
    puts "Schedule created successfully!"

  end

end
