class UpdateFootballersJob < ApplicationJob
  queue_as :default

  # Job to call FPL API to retrieve uptodate Footballer data and persist to DB
  def perform
    url = 'https://fantasy.premierleague.com/api/bootstrap-static/'
    response = URI.open(url).read
    deserialized = JSON.parse(response)

    # Iterate over each player in API response
    deserialized['elements'].each do |footballer|
      # Finds club from DB and initialized instance
      club = Club.find_by(fplid: footballer['team'])
      # Converts FPL position code to applicable string
      case footballer['element_type']
      when 1 then position = 'GK'
      when 2 then position = 'DEF'
      when 3 then position = 'MID'
      when 4 then position = 'FWD'
      else
        position = 'UNKNOWN'
      end
      # Checks to see if player exists in DB, and if so initializes instance
      player = Footballer.find_by(fplid: footballer['team'])
      # If instance is nil, we do not hold in DB, and therefore create new player
      if player.nil?
        Footballer.create!(
          first_name: footballer['first_name'],
          last_name: footballer['second_name'],
          web_name: footballer['web_name'],
          price: footballer['now_cost'],
          position: position,
          total_points: footballer['total_points'],
          goals: footballer['goals_scored'],
          assists: footballer['assists'],
          clean_sheets: footballer['clean_sheets'],
          yellow_cards: footballer['yellow_cards'],
          red_cards: footballer['red_cards'],
          saves: footballer['saves'],
          goals_conceded: footballer['goals_conceded'],
          own_goals: footballer['own_goals'],
          penalties_saved: footballer['penalties_saved'],
          penalties_missed: footballer['penalties_missed'],
          bonus: footballer['bonus'],
          bps: footballer['bps'],
          club: club,
          fplid: footballer['id'],
          chance_of_playing_next_round: footballer['chance_of_playing_next_round'],
          chance_of_playing_this_round: footballer['chance_of_playing_this_round'],
          news: footballer['news'],
          form: footballer['form']
          )
      # Else player DOES exist in DB, and therefore we update values
      else
        player.update!(
          first_name: footballer['first_name'],
          last_name: footballer['second_name'],
          web_name: footballer['web_name'],
          price: footballer['now_cost'],
          position: position,
          total_points: footballer['total_points'],
          goals: footballer['goals_scored'],
          assists: footballer['assists'],
          clean_sheets: footballer['clean_sheets'],
          yellow_cards: footballer['yellow_cards'],
          red_cards: footballer['red_cards'],
          saves: footballer['saves'],
          goals_conceded: footballer['goals_conceded'],
          own_goals: footballer['own_goals'],
          penalties_saved: footballer['penalties_saved'],
          penalties_missed: footballer['penalties_missed'],
          bonus: footballer['bonus'],
          bps: footballer['bps'],
          club: club,
          chance_of_playing_next_round: footballer['chance_of_playing_next_round'],
          chance_of_playing_this_round: footballer['chance_of_playing_this_round'],
          news: footballer['news'],
          form: footballer['form']
          )
      end
    end
  end
end
