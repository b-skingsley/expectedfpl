require 'open-uri'
require 'json'

# Calling the API
def completed_games_data
  fixtures_url = 'https://fantasy.premierleague.com/api/fixtures/'
  request = URI.open(fixtures_url).read
  data = JSON.parse(request)
  data.select { |f| f["finished"] == true }
end

def bps_per_game(player_fpl_id)
  finished_games = completed_games_data
  most_recent_gameweek = finished_games.last["event"]
  
  # Filter only relevant data (bps)
  finished_games.map! do |game|
      (game["stats"][9]["a"] + game["stats"][9]["h"])
  end

  counter = most_recent_gameweek
  arr = [] 
  while counter > 0 do   
    player_points_hash = Hash.new(0)
    player_points_hash[player_fpl_id] = 0
    
    gameweek_allocated_points = finished_games[most_recent_gameweek - counter].to_a.flatten
    gameweek_allocated_points.map! do |game|
        game.values
    end

    player_gameweek_points = gameweek_allocated_points.select { |point_allocation| point_allocation[1] == player_fpl_id }
    player_gameweek_points.flatten ? arr << player_gameweek_points.flatten[0] : arr << [0]
    counter -= 1
  end

  arr.map! { |i| i.nil? ? i = 0 : i }

  points_by_game = Hash.new
  arr.each_with_index do |element, index|
    points_by_game[index] = element
  end
  points_by_game
end


# Method for calculating moving average
def wma_hash(hash, maws = MAWS)
  sum = maws * (maws + 1) / 2

  values = hash.to_a # recent averages are the most important ones
  values_size = values.size

  values.each_with_index do |kv, pos|
    weighted_sum = 0

    0.upto(maws - 1) do |i|
      weighted_sum += values[i + pos].last * (i + 1)
    end

    hash[values[pos+1].first] = weighted_sum.to_f / sum

    return hash if pos + maws == values_size
  end
end

# Example use:
# (0..Footballer.count).each do |fpl_id|
#     p wma_hash(bps_per_game(fpl_id), maws = 3)
# end


# Minutes played per player
bootstrap_static_url = 'https://fantasy.premierleague.com/api/bootstrap-static/'
raw = URI.open(bootstrap_static_url).read
player_data = JSON.parse(raw)["elements"]

player_hash = Hash.new

player_data.each do |player|
    player_hash[player["id"]] = player["minutes"]
end
