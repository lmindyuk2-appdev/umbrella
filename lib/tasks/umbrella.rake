task(:umbrella) do
  weather_file = open("https://api.darksky.net/forecast/26f63e92c5006b5c493906e7953da893/41.8887,-87.6355").read
  weather_parsed_file = JSON.parse(weather_file)
  ap weather_parsed_file['currently']['temperature']

  geocoding_url = "https://maps.googleapis.com/maps/api/geocode/json?address=Merchandise%20Mart%20Chicago&key=AIzaSyDB6uZXmYRlo88RLhAxD-yxUbMIZd4oHpg"
  address_raw_file = open(geocoding_url).read
  address_parsed_file = JSON.parse(address_raw_file)

  ap address_parsed_file
end