require 'open-uri'
require 'json'

module FootballerHelper
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

  def player_historical_data(fplid)
    url = 'https://fantasy.premierleague.com/api/element-summary/' + "#{fplid.to_s}/"
    request = URI.open(url).read
    data = JSON.parse(request)
    data["history"].flatten
  end

  def historical_value(fplid)
    values = player_historical_data(fplid).map { |hash| hash.select { |attribute| attribute["value"] } }
    arr = []
    values.each_with_index { |hash, index| arr << { (index + 1) => hash["value"] } }
    arr
  end

  def popularity(fplid)
    ongoing_values = player_historical_data(fplid).map { |hash| hash.select { |attribute| attribute["transfers_balance"] } }
    arr = []
    current = 0
    # array.reduce(0) { |sum, num| sum + num }
    ongoing_values.each_with_index do |hash, index|
      current += hash["transfers_balance"]
      arr << { (index + 1) => current }
    end
    arr.reduce Hash.new, :merge
  end
 

  def bps(fplid)
    values = player_historical_data(fplid).map { |hash| hash.select { |attribute| attribute["bps"] } }
    arr = []
    values.each_with_index do |hash, index|
      arr << { (index + 1) => hash["bps"] }
    end
    arr
  end

    # Method for calculating moving average
  def wma_hash(hash, maws = MAWS)
    hash = hash.reduce Hash.new, :merge
    sum = maws * (maws + 1) / 2

    values = hash.to_a.reverse # recent averages are the most important ones
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
end

