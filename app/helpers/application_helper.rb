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
    when 100
      return '😃'
    when 75
      return '🤨'
    when 50
      return '😬'
    when 25
      return '🙁'
    else
      return '😩'
    end
  end

  def next_deadline()
    next_gw = Fixture.gameweek.first.gameweek
    deadline = 90.minutes.before(Fixture.where(gameweek: next_gw).first.kickoff)
    return deadline.strftime("%a %b-%-dth @ %H:%M")
  end

end
