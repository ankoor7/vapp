# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.destroy_all
Event.destroy_all
Group.destroy_all
Charity.destroy_all


firstnames = ["Adam", "Salman", "James", "Andrea", "Britney", "Luke", "Will", "Charles J", "Stewart", "Julien", "Ankoor", "Emile"]
lastnames = ["Smith", "Westfield", "Hogan", "Skywalker", "Simpson", "Threadneedle", "Rothchild", "Kenobi", "Powers"]

addresses = ["15-17 New Street Square, Fetter Ln, London EC4A 3AP", "Broadgate Tower, 20 Primrose Street, London EC2A 2EW","3-7 Stamford St, London SE1 9NY", "29-31 Wellington St, Covent Garden, London WC2E 7DB", "79a Tottenham Court Rd, London W1T 4TD", "6 Dorset Square, London NW1 6QA", "Queen Marys Gardens, London", "115 New Cavendish St, London W1W 6UW", "Paramount House, 162-170 Wardour St, London W1F 8ZX", "2 Hogarth Rd, London, Earls Court, London, Greater London SW5 0PT"]

group_slogan = "Helping the world get better"

group_description = "Kale chips meh cardigan drinking vinegar. Helvetica pop-up umami, vinyl raw denim pour-over try-hard biodiesel gentrify hella ethnic whatever mustache salvia Godard. 3 wolf moon irony quinoa, asymmetrical PBR Truffaut sriracha YOLO mumblecore forage Williamsburg synth blog selfies High Life. Banjo disrupt Williamsburg fashion axe Etsy. Terry Richardson post-ironic mlkshk twee plaid. Narwhal twee drinking vinegar Blue Bottle, hashtag master cleanse letterpress Williamsburg try-hard tofu pork belly mixtape distillery 8-bit. Marfa gentrify Pitchfork +1 chia, yr messenger bag 90's readymade chillwave cornhole photo booth chambray keytar."

event_description = "Kale chips meh cardigan drinking vinegar. Helvetica pop-up umami, vinyl raw denim pour-over try-hard biodiesel gentrify hella ethnic whatever mustache salvia Godard. 3 wolf moon irony quinoa, asymmetrical PBR Truffaut sriracha YOLO mumblecore forage Williamsburg synth blog selfies High Life. Banjo disrupt Williamsburg fashion axe Etsy. Terry Richardson post-ironic mlkshk twee plaid. Narwhal twee drinking vinegar Blue Bottle, hashtag master cleanse letterpress Williamsburg try-hard tofu pork belly mixtape distillery 8-bit. Marfa gentrify Pitchfork +1 chia, yr messenger bag 90's readymade chillwave cornhole photo booth chambray keytar."

event_special_instructions = "Narwhal twee drinking vinegar Blue Bottle, hashtag master cleanse letterpress Williamsburg try-hard tofu pork belly mixtape distillery 8-bit. Marfa gentrify Pitchfork 1 chia, yr messenger bag 90's readymade chillwave cornhole photo booth chambray keytar."

causes = ["food", "people", "mentoring", "music", "art", "science", "education", "health", "money", "poverty", "tech", "digital", "marketing", "elderly", "youth", "social welfare"]

group = nil
event = nil
user = nil
group_index = 1
volunteer_index = 1
# Setup a single charity
  # charity = Charity.new(email: "test_charity_emailgmail.com", description: "A new charity on the system. Helping the world, one kid at a time.", location: "9 Back Hill, London, N1", name: "The Charity", website: "test_charity.com", phone: "07903555555")
  # charity.save

logos_path = "/app/assets/seed_pics/logos/"
images_path = "/app/assets/seed_pics/images/"

charities = {
  foodcycle: "FoodCycle",
  oxfam: "Oxfam",
  unicef: "Unicef",
  hackneypirates: "Hackney Pirates",
  ytfn: "YTFN",
  chayn: "Chayn",
  studentfunder: "Student Funder",
  makesense: "MakeSense"
}

videos = {
  foodcycle: "http://www.youtube.com/watch?v=vqrRMFOOPf8",
  oxfam: "http://www.youtube.com/watch?v=hkg9ADEIPXM",
  unicef: "http://www.youtube.com/watch?v=NmmnciqOLQw",
  hackneypirates: "http://www.youtube.com/watch?v=q8PXp3rujwg",
  ytfn: "http://www.youtube.com/watch?v=1yaEdF7--E8",
  chayn: "",
  studentfunder: "",
  makesense: "http://www.youtube.com/watch?v=VwegvObubhI"
}

splash_images = {
  foodcycle: "http://www.flickr.com/photos/61527873@N05/5904837605",
  oxfam: "http://www.flickr.com/photos/oxfam/9408920586/",
  unicef: "http://www.flickr.com/photos/u10k/5043631738/lightbox/",
  hackneypirates: "http://www.flickr.com/photos/34207052@N02/7995547490",
  ytfn: "http://www.flickr.com/photos/45347326@N02/4661645806",
  chayn: "",
  studentfunder: "http://www.flickr.com/photos/58726828@N08/7154019121",
  makesense: "http://www.flickr.com/photos/90045808@N06/8182975487"
}


# Make test Groups and events by nested loops
# Loop through groups
charities.each do |k,v|
    cause_sample = causes.sample(Random.new.rand(1..4)).join(", ")
    group = Group.new(email: "test_charity_email_#{k.to_s}@gmail.com", description: group_description, slogan: group_slogan, cause_list: cause_sample, cause_search_hack: cause_sample, location: addresses[group_index], name: "#{v}", website: "#{k.to_s}.com", phone: "0790355555#{group_index}", logo: File.new(File.join(Rails.root.to_s, logos_path, k.to_s + ".jpg")), video: videos[k])
    # , splash_image: splash_images[k]

    group.save
    group_index += 1
    (rand(1..3)).times do |volunteer_num|
      user = User.new(email: "test_leader_#{volunteer_num}@#{k}.com", firstname: firstnames.sample, lastname: lastnames.sample, phone: "0790355555#{volunteer_num}", password: "password", password_confirmation: "password", t_and_c: true)
      user.save

      group.leaders << user
      group.save
      volunteer_index += 1
    end

    # Loop through events
    (rand(4..6)).times do |event_num|
      cause_sample_event = causes.sample(Random.new.rand(1..2)).join(", ")
      event = Event.new(date: (DateTime.now + rand(15)), description: "A test event by #{group.name}", location: addresses.sample, description: event_description, cause_list: cause_sample_event, cause_search_hack: cause_sample_event, special_instructions: event_special_instructions, latitude: "", longitude: "", name: "Event #{event_num} at #{group.name}", number_volunteers: rand(9..16), image: File.new(File.join(Rails.root.to_s, images_path, k.to_s + ".jpg")))
      event.group = group
      event.save

      # Add volunteers to events

      (rand(5..9)).times do |volunteer_num|
        user = User.new(email: "test_user_#{volunteer_index}@#{k}.com", firstname: firstnames.sample, lastname: lastnames.sample, phone: "0790355555#{volunteer_num}", password: "password", password_confirmation: "password", t_and_c: true)
        user.save

        event.volunteers << user
        event.save
        volunteer_index += 1
      end
      group.volunteers << user
    end
  group.save

end

# Make volunteers







