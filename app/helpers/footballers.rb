require 'json'
require 'open-uri'
require 'nokogiri'

def get_footballer_data
  # call FPL API for footballers info
  url = 'https://fantasy.premierleague.com/api/bootstrap-static/'
  response = open(url).read
  deserialized = JSON.parse(response)

  puts deserialized['elements'].first

end
