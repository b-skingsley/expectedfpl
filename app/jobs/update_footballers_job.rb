require_relative "../app/helpers/premier_league"

class UpdateFootballersJob < ApplicationJob
  queue_as :default

  # Job to call FPL API to retrieve uptodate Footballer data and persist to DB
  def perform
    url = 'https://fantasy.premierleague.com/api/bootstrap-static/'
    response = URI.open(url).read
    deserialized = JSON.parse(response)

    deserialized['elements'].each do |footballer|

    case footballer['element_type']
    when 1 then position = 'GK'
    when 2 then position = 'DEF'
    when 3 then position = 'MID'
    when 4 then position = 'FWD'
    else
      position = 'UNKNOWN'
    end

    club = Club.find_by(fplid: footballer['team'])

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
      fplid: footballer['id']
      )
    end
  end
end
