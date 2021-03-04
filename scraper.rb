require "nokogiri"
require 'open-uri'

url = "https://fantasy.premierleague.com/entry/4921261/event/26/"

html = URI.open(url).read
doc = Nokogiri::HTML(html)
puts doc.text
puts doc.search(".Panel__PanelHeading-sc-1nmpshp-2")
doc.search("div[class='PitchElementData__ElementName-sc-1u4y6pr-0.eMnDEV']").each do |data|
  puts data.text
end
