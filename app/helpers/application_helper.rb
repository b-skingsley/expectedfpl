module ApplicationHelper
  def fplprice(price)
    return price / 10.0
  end

  def current_class?(test_path)
    return 'active' if request.path == test_path
    ''
  end

  def defs(players)
    defs = []
    players.each do |player|
      if player.footballer.position == "DEF"
        defs << player.footballer
      end
    end
    return defs
  end

  def mids(players)
    mids = []
    players.each do |player|
      if player.footballer.position == "MID"
        mids << player.footballer
      end
    end
    return mids
  end

  def fwds(players)
    fwds = []
    players.each do |player|
      if player.footballer.position == "FWD"
        fwds << player.footballer
      end
    end
    return fwds
  end

  def gks(players)
    gks = []
    players.each do |player|
      if player.footballer.position == "GK"
        gks << player.footballer
      end
    end
    return gks
  end

  def outfielders(players)
    outfielders = []
    players.each do |player|
      unless player.footballer.position == "GK"
        outfielders << player.footballer
      end
    end
    return outfielders
  end

  def form_formatter(form)
    form > 5.0 ? '🔥' : ''
  end

  def chances_formatter(chance)
    case chance
    when 100 then return '👍🏼'
    when nil then return '👍🏼'
    when 0 then return '❌'
    else
      return '😬'
    end
  end

  def progress_bar(num)
    `<progress id="file" max="100" value="#{num}"> 70% </progress>`
  end

  def next_gameweek
    url = 'https://fantasy.premierleague.com/api/bootstrap-static/'
    response = URI.open(url).read
    deserialized = JSON.parse(response)

    deserialized['events'].each_with_index do | gameweek, index |
      if gameweek['is_next']
        return [gameweek['deadline_time'], deserialized['events'][index + 1]['deadline_time']]
      end
    end
    return nil
  end

  def next_gameweek_no
    url = 'https://fantasy.premierleague.com/api/bootstrap-static/'
    response = URI.open(url).read
    deserialized = JSON.parse(response)
    deserialized['events'].each do | gameweek |
      if gameweek['is_next']
        return gameweek['id']
      end
    end
    return nil
  end

  def current_gameweek_no
    url = 'https://fantasy.premierleague.com/api/bootstrap-static/'
    response = URI.open(url).read
    deserialized = JSON.parse(response)
    deserialized['events'].each do | gameweek |
      if gameweek['is_current']
        return gameweek['id']
      end
    end
  end

  def next_fixture(footballer)
    club = footballer.club
    @next_gw = next_gameweek_no
    @gw_range = (@next_gw..(@next_gw + 2))
    fixture = Fixture.includes(:away_team, :home_team)
                      .where(gameweek: @gw_range, home_team: club)
                      .or(Fixture.includes(:away_team, :home_team)
                      .where(gameweek: @gw_range, away_team: club))
                      .order(:kickoff)
                      .first
    if fixture.home_team == club
      return "#{fixture.away_team.short_name} (H)"
    else
      return "#{fixture.home_team.short_name} (A)"
    end
  end

  def next_fixtures(footballer, num)
    club = footballer.club
    next_gw = next_gameweek_no
    gw_range = (next_gw..(next_gw + 6))
    fixtures = Fixture.includes(:away_team, :home_team)
                      .where(gameweek: gw_range, home_team: club)
                      .or(Fixture.includes(:away_team, :home_team)
                      .where(gameweek: gw_range, away_team: club))
                      .order(:kickoff)
                      .first(num)
    fixtures_details = []
    fixtures.each do |fixture|
      if fixture.home_team == club
        fixtures_details << {opponent: fixture.away_team.short_name, kickoff: fixture.kickoff, shirt: fixture.away_team.short_name.downcase, home_or_away: "(H)", difficulty: fixture.home_team_difficulty, opponent_long: fixture.away_team.name}
      else
        fixtures_details << {opponent: fixture.home_team.short_name, kickoff: fixture.kickoff, shirt: fixture.home_team.short_name.downcase, home_or_away: "(A)", difficulty: fixture.away_team_difficulty, opponent_long: fixture.home_team.name}
      end
    end
    return fixtures_details
  end

  def next_five(footballer)
    club = footballer.club
    next_gw = next_gameweek_no
    gw_range = (next_gw..(next_gw + 6))
    fixtures = Fixture.includes(:away_team, :home_team)
                      .where(gameweek: gw_range, home_team: club)
                      .or(Fixture.includes(:away_team, :home_team)
                      .where(gameweek: gw_range, away_team: club))
                      .order(:kickoff)
                      .first(5)
    fixtures_details = []
    fixtures.each do |fixture|
      if fixture.home_team == club
        fixtures_details << {opponent: fixture.away_team.short_name, home_or_away: "(H)", difficulty: fixture.home_team_difficulty, date: fixture.kickoff.strftime("%d/%m"), goals: fixture.ht_possible_goals, cs: fixture.ht_clean_sheet_probability, kickoff: fixture.kickoff}
      else
        fixtures_details << {opponent: fixture.home_team.short_name, home_or_away: "(A)", difficulty: fixture.away_team_difficulty, date: fixture.kickoff.strftime("%d/%m"), goals: fixture.at_possible_goals, cs: fixture.at_clean_sheet_probability, kickoff: fixture.kickoff}
      end
    end
    return fixtures_details.first(5)
  end

  def attributes_list(footballer)
    arr = []
    if footballer.goals > 5
      arr << {"Goalscorer" => "fas fa-futbol"}
    end
    if footballer.assists > 5
      arr << {"Prolific Assister" => "far fa-handshake"}
    end
    if footballer.yellow_cards + footballer.red_cards > 6
      arr << {"Dirty Player" => "fas fa-copy"}
    end
    if footballer.minutes / (next_gameweek_no - 1) > 65
      arr << {"Consistent Starter" => "fas fa-hourglass-half"}
    end
    if footballer.saves > 50
      arr << {"Prolific Saver" => "fas fa-hand-paper"}
    end
    if footballer.price > 50
      arr << {"Pricey" => "fas fa-pound-sign"}
    end
    arr
  end

  def price_sum(team)
    value = 0
    team.players.each do |player|
      value += player.footballer.price
    end
    return value
  end
end
