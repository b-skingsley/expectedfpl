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
end
