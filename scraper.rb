require "nokogiri"
require 'open-uri'

team_id = 4921261
url = "https://www.premierfantasytools.com/live-fpl-rank/?teamid=#{team_id}"

html = URI.open(url).read
doc = Nokogiri::HTML(html)
# puts doc.text.strip
# doc.search(".playerRow").each do |data|
#   puts data.text.strip
# end
puts doc.search("#name1").text

# doc.search("div[class='PitchElementData__ElementName-sc-1u4y6pr-0.eMnDEV']").each do |data|
#   puts data.text
# end
