task(:umbrella) do

  user_location = "340 E North Water"

  geocoding_url = "https://maps.googleapis.com/maps/api/geocode/json?address=" + user_location + "&key=" + ENV.fetch("GEOCODING_API_KEY")
  address_raw_file = open(geocoding_url).read
  address_parsed_file = JSON.parse(address_raw_file)


  latitude = address_parsed_file["results"][0]["geometry"]["location"]["lat"]
  longitude = address_parsed_file["results"][0]["geometry"]["location"]["lng"]

  weather_file = open("https://api.darksky.net/forecast/" + ENV.fetch("DARKSKY_API_KEY") + "/" + latitude.to_s + "," + longitude.to_s).read
  weather_parsed_file = JSON.parse(weather_file)

  current_time = Time.at(weather_parsed_file["currently"]["time"])
  current_temperature = weather_parsed_file['currently']['temperature']
  p "Current temperature is #{current_temperature}."
  p "Current outlook: #{weather_parsed_file['hourly']['summary']}"
  require "date"
  require "time"
  n = 1
  number_of_hours_ahead = 12
  likely_to_rain = 0
  rain_probability_threshold = 0.5
  
  # I prefer doing multiple API calls rather than getting forecast from the initial parsed file.
  number_of_hours_ahead.times { 
  adjusted_datetime = (current_time + n.hours).to_datetime.to_i
  weather_file = open("https://api.darksky.net/forecast/" + ENV.fetch("DARKSKY_API_KEY") + "/" + latitude.to_s + "," + longitude.to_s + "," + adjusted_datetime.to_s).read
  weather_parsed_file = JSON.parse(weather_file)
  if weather_parsed_file['currently']['precipProbability'] > rain_probability_threshold
    likely_to_rain = likely_to_rain + 1
  end
  n = n + 1
  }

  if likely_to_rain == 0
      p "You are lucky! It is not going to rain today."
  else 
    p "It is likely to rain in the next #{number_of_hours_ahead}. Don't forget an umbrella!"
  end
  
end