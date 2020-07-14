task(:umbrella) do
  latitude = 41.8887
  longitude = -87.6355

  weather_file = open("https://api.darksky.net/forecast/" + ENV.fetch("DARKSKY_API_KEY") + "/" + latitude.to_s + "," + longitude.to_s).read
  weather_parsed_file = JSON.parse(weather_file)
  ap weather_parsed_file['currently']['temperature']

  user_location = "Willis Tower"

  geocoding_url = "https://maps.googleapis.com/maps/api/geocode/json?address=" + user_location + "&key=" + ENV.fetch("GEOCODING_API_KEY")
  address_raw_file = open(geocoding_url).read
  address_parsed_file = JSON.parse(address_raw_file)

  ap address_parsed_file
end