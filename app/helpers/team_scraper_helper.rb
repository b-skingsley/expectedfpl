module TeamScraperHelper
  def teamscrape(fplid)
    url2 = "https://fantasy.premierleague.com/api/entry/#{fplid}/"
    response2 = URI.open(url2).read
    deserialized2 = JSON.parse(response2)
    gw = deserialized2['current_event']
    overall_points = deserialized2['summary_overall_points']
    overall_rank = deserialized2['summary_overall_rank']
    url = "https://fantasy.premierleague.com/api/entry/#{fplid}/event/#{gw}/picks/"
    response = URI.open(url).read
    deserialized = JSON.parse(response)
    data = {}
    players = []
    deserialized['picks'].each do |player|
      players << [Footballer.find_by(fplid: player['element']), player['position']]
    end
    budget = deserialized['entry_history']['bank']
    data[:players] = players
    data[:budget] = budget
    data[:points] = overall_points
    data[:rank] = overall_rank
    data[:team_value] = deserialized['entry_history']['value']
    return data
  end

  def leagues(fplid)
    url2 = "https://fantasy.premierleague.com/api/entry/#{fplid}/"
    response2 = URI.open(url2).read
    deserialized2 = JSON.parse(response2)
    leagues = []
    deserialized2['leagues']['classic'].each do |league|
      if league['league_type'] == "x"
        leagues << [league['name'], league['id']]
      end
    end
    return leagues
  end
end
