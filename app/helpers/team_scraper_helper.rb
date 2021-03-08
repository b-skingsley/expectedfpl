require "nokogiri"
require "open-uri"

module TeamScraperHelper
  def teamscrape
    url = "https://fantasy.premierleague.com/entry/4921261/event/26/"
    visit(url)
    doc = Nokogiri::HTML.parse(body)
    puts doc
    # url = "https://fantasy.premierleague.com/entry/38281/event/26/"
    # html = URI.open(url).read
    # doc = Nokogiri::HTML(html)
    # doc.search("div[class='PitchElementData__ElementName-sc-1u4y6pr-0 eMnDEV']").each do |data|
    #   p data.text.strip.split
    # end
  end
end
