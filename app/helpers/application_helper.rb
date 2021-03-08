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
    when 100 then return '✅'
    when 0 then return '❌'
    else
      return '😬'
    end
  end

  def next_gameweek()
    url = 'https://fantasy.premierleague.com/api/bootstrap-static/'
    response = URI.open(url).read
    deserialized = JSON.parse(response)

    deserialized['events'].each do | gameweek |
      if gameweek['is_next']
        return [gameweek['name'], gameweek['deadline_time']]
      end
    end
    return nil
  end

  def next_deadline()
    next_gw = Fixture.gameweek.first.gameweek
    deadline = 90.minutes.before(Fixture.where(gameweek: next_gw).first.kickoff)
    return "#{deadline.strftime('%Y')}, #{deadline.strftime('%-m').to_i - 1}, #{deadline.strftime('%-d')}, #{deadline.strftime('%H')}, #{deadline.strftime('%M')}"
  end

  def next_gameweek
    url = 'https://fantasy.premierleague.com/api/bootstrap-static/'
    request = URI.open(url).read
    request_hash = JSON.parse(request)

  end

  def next_fixture(footballer)
    club = footballer.club
  end
end
