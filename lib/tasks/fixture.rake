# TODO: This file needs to scrape the current overall season goals before it can be executed (otherwise it will use a default value)

namespace :fixture do
  desc "Calculate the predictions for the next fixtures (the daily_update - task has to be done before)"
  task calculate_predictions: :environment do
    # !!This code works for predicting the goals for the HOME and AWAY team (edit this line if this information is no longer true)

    # Support

    def self.average_goals(goals, matches)
      goals.to_f / matches
    end

    # Prediction

    def self.attack_strength(season_total_goals_scored, number_of_games, leagues_goals, leagues_matches)
      # !When calling the method:
      # For Hometeam: All 4 Arguments have to be "home"-values
      # For Awayteam: All 4 Arguments have to be "away"-values
      average_goals(season_total_goals_scored, number_of_games) / average_goals(leagues_goals, leagues_matches)
    end

    def self.defense_strength(season_total_goals_conceded, number_of_games, leagues_conceded_goals, leagues_matches)
      # !When calling the method:
      # For Hometeam: All 4 Arguments have to be "home"-values
      # For Awayteam: All 4 Arguments have to be "away"-values
      average_goals(season_total_goals_conceded, number_of_games) / average_goals(leagues_conceded_goals, leagues_matches)
    end

    def self.possible_goals(attack_strength, defense_strength_opponent, leagues_home_goals, leagues_home_matches)
      # !When calling the method:
      # For Hometeam: Arguments 1, 3, 4 have to be "home"-values / Argument 2 has to be "away"-value, because it's the defense strenght of the opponent
      # For Awayteam: Arguments 1, 3, 4 have to be "away"-values / Argument 2 has to be "home"-value, because it's the defense strength of the opponent
      average_number_of_goals_scored_at_home_league = average_goals(leagues_home_goals, leagues_home_matches)
      attack_strength * defense_strength_opponent * average_number_of_goals_scored_at_home_league
    end

    # League Information (Season) -------------------------------
    # Number of Matches
    leagues_home_matches = 240
    leagues_away_matches = 240
    # Attack Strength
    leagues_home_goals = 355
    leagues_away_goals = 311
    # Defense Stength
    leagues_conceded_home_goals = 311
    leagues_conceded_away_goals = 355


    # Team Information ------------------------------------------
    # Team Home ----- (Leicester)
    ht_number_of_games_at_home = 12
    # Attack Strength
    ht_season_total_goals_scored_at_home = 24
    # Defense Strength
    ht_season_total_goals_conceded_at_home = 12

    # Team Away ----- (Chelsea)
    at_number_of_games_away = 12
    # Attack Strength
    at_season_total_goals_scored_away = 25
    # Defence Strength
    at_season_total_goals_conceded_away = 20


    # -----------------------------------------------------------

    ht_attack_strength = attack_strength(ht_season_total_goals_scored_at_home, ht_number_of_games_at_home, leagues_home_goals, leagues_home_matches)
    puts "Hometeam:"
    p "Hometeam Attack Strength:  #{ht_attack_strength.round(2)}"
    at_defense_strength = defense_strength(at_season_total_goals_conceded_away, at_number_of_games_away, leagues_conceded_away_goals, leagues_away_matches)
    p "Awayteam Defense Strength: #{at_defense_strength.round(2)}"
    ht_possible_goals = possible_goals(ht_attack_strength, at_defense_strength, leagues_home_goals, leagues_home_matches)
    p "Possible goals (Hometeam): #{ht_possible_goals.round(2)}"
    puts ""
    puts "Awayteam:"
    at_attack_strength = attack_strength(at_season_total_goals_scored_away, at_number_of_games_away, leagues_away_goals, leagues_away_matches)
    p "Awayteam Attack Strength:  #{at_attack_strength.round(2)}"
    ht_defense_strength = defense_strength(ht_season_total_goals_conceded_at_home, ht_number_of_games_at_home, leagues_conceded_home_goals, leagues_home_matches)
    p "Hometeam Defense Strength: #{ht_defense_strength.round(2)}"
    at_possible_goals = possible_goals(at_attack_strength, ht_defense_strength, leagues_away_goals, leagues_away_matches)
    p "Possible goals (Awayteam): #{at_possible_goals.round(2)}"



    # Poisson distribution ---------------------------------------

    # support

    def self.factorial(n)
      (2...n).each { |i| n *= i }
      n.zero? ? 1 : n
    end

    # prediction

    def self.result_probability(ht_actual_goals, ht_possible_goals, at_actual_goals, at_possible_goals)
      ((Math::E ** -ht_possible_goals * ht_possible_goals ** ht_actual_goals) / factorial(ht_actual_goals)) * ((Math::E ** -at_possible_goals * at_possible_goals ** at_actual_goals) / factorial(at_actual_goals))
    end

    p result_probability(2, ht_possible_goals, 2, at_possible_goals)

    def self.create_poisson_table(ht_possible_goals, at_possible_goals)
      poisson_distribution_table = []
      poisson_distribution_table_row = []
      (0..9).each do |ht_goals|
        (0..9).each do |at_goals|
          poisson_distribution_table_row << (result_probability(ht_goals, ht_possible_goals, at_goals, at_possible_goals) * 100).round(2)
        end
        poisson_distribution_table << poisson_distribution_table_row
        poisson_distribution_table_row = []
      end
      poisson_distribution_table
    end

    poisson_distribution_table = create_poisson_table(ht_possible_goals, at_possible_goals)

    def self.print_poisson_distribution_table(poisson_distribution_table)
      poisson_distribution_table.each do |row|
        p row
      end
    end

    print_poisson_distribution_table(poisson_distribution_table)

    # Clean Sheet ------------------------------------------------

    def self.ht_clean_sheet_probability(poisson_distribution_table)
      poisson_distribution_table.reduce(0) { |sum, row| sum + row[0] }
    end

    puts "Hometeam Clean Sheet Probability: #{ht_clean_sheet_probability(poisson_distribution_table).round(2)} %"

    def self.at_clean_sheet_probability(poisson_distribution_table)
      poisson_distribution_table[0].sum
    end

    puts "Awayteam Clean Sheet Probability: #{at_clean_sheet_probability(poisson_distribution_table).round(2)} %"

    # Win / Draw / Lose ------------------------------------------

    def self.draw_probability(poisson_distribution_table)
      draw_probabilities = []
      at_goals = 0
      (0..9).each do |ht_goals|
        draw_probabilities << poisson_distribution_table[ht_goals][at_goals]
        at_goals += 1
      end
      draw_probabilities.sum
    end

    puts "Draw Probability:                 #{draw_probability(poisson_distribution_table)} %"

    def self.ht_win_probability(poisson_distribution_table)
      win_probabilities = []
      end_column = 0
      (1..9).each do |ht_goals|
        (0..end_column).each do |at_goals|
          win_probabilities << poisson_distribution_table[ht_goals][at_goals]
        end
        end_column += 1
      end
      win_probabilities.sum
    end

    puts "Hometeam Win Probability:         #{ht_win_probability(poisson_distribution_table)} %"

    def self.at_win_probability(poisson_distribution_table)
      win_probabilities = []
      start_column = 1
      (0..8).each do |ht_goals|
        (start_column..9).each do |at_goals|
          win_probabilities << poisson_distribution_table[ht_goals][at_goals]
        end
        start_column += 1
      end
      win_probabilities.sum
    end

    puts "Awayteam Win Probability:         #{at_win_probability(poisson_distribution_table)} %"

    def self.prediction(ht_number_of_games_at_home, ht_season_total_goals_scored_at_home, ht_season_total_goals_conceded_at_home, at_number_of_games_away, at_season_total_goals_scored_away, at_season_total_goals_conceded_away, leagues_home_matches, leagues_away_matches, leagues_home_goals, leagues_away_goals, leagues_conceded_home_goals, leagues_conceded_away_goals)
      # Define an empty Odd Hash
      odds = {}

      # Possible Goals for the Hometeam
      ht_attack_strength = attack_strength(ht_season_total_goals_scored_at_home, ht_number_of_games_at_home, leagues_home_goals, leagues_home_matches)
      at_defense_strength = defense_strength(at_season_total_goals_conceded_away, at_number_of_games_away, leagues_conceded_away_goals, leagues_away_matches)
      odds[:ht_possible_goals] = possible_goals(ht_attack_strength, at_defense_strength, leagues_home_goals, leagues_home_matches)
      
      # Possible Goals for the Awayteam
      at_attack_strength = attack_strength(at_season_total_goals_scored_away, at_number_of_games_away, leagues_away_goals, leagues_away_matches)
      ht_defense_strength = defense_strength(ht_season_total_goals_conceded_at_home, ht_number_of_games_at_home, leagues_conceded_home_goals, leagues_home_matches)
      odds[:at_possible_goals] = possible_goals(at_attack_strength, ht_defense_strength, leagues_away_goals, leagues_away_matches)
      
      # Create Poisson Distributaion Table
      poisson_distribution_table = create_poisson_table(odds[:ht_possible_goals], odds[:at_possible_goals])
      
      # Clean Sheet
      odds[:ht_clean_sheet_probability] = ht_clean_sheet_probability(poisson_distribution_table).round(2)
      odds[:at_clean_sheet_probability] = at_clean_sheet_probability(poisson_distribution_table).round(2)
      
      # Win / Draw / Lose -Probability
      odds[:ht_win_probability] = ht_win_probability(poisson_distribution_table)
      odds[:draw_probability] = draw_probability(poisson_distribution_table)
      odds[:at_win_probability] = at_win_probability(poisson_distribution_table)
      
      # Return the Prediction Hash
      "Here is the prediction hash later on"
      odds
    end

    # Test ---------------------------------- 

    # create an Array with all Fixture IDs for this Season
    all_fpl_fixture_ids = Fixture.pluck(:id)

    # for each fixture calculate the probabilities
    all_fpl_fixture_ids.each do |fpl_fixture_id|
      fpl_fixture = Fixture.find(fpl_fixture_id)
      
      # get the team ID for both clubs
      print "ht: "
      p ht_id = fpl_fixture.home_team_id 
      print "at: "
      p at_id = fpl_fixture.away_team_id

      # use team ID to get the relavant data from the club table
      p home_club = Club.find(ht_id)
      p away_club = Club.find(at_id)

      # Team Information ------------------------------------------
      # Team Home -----
      ht_number_of_games_at_home = home_club.number_of_games_at_home
      # Attack Strength
      ht_season_total_goals_scored_at_home = home_club.season_total_goals_scored_at_home
      # Defense Strength
      ht_season_total_goals_conceded_at_home = home_club.season_total_goals_conceded_at_home

      # Team Away -----
      at_number_of_games_away = away_club.number_of_games_away
      # Attack Strength
      at_season_total_goals_scored_away = away_club.season_total_goals_scored_away
      # Defence Strength
      at_season_total_goals_conceded_away = away_club.season_total_goals_conceded_away

      # Call Prediction Method for testing purposes
      p prediction = prediction(ht_number_of_games_at_home, ht_season_total_goals_scored_at_home, ht_season_total_goals_conceded_at_home, at_number_of_games_away, at_season_total_goals_scored_away, at_season_total_goals_conceded_away, leagues_home_matches, leagues_away_matches, leagues_home_goals, leagues_away_goals, leagues_conceded_home_goals, leagues_conceded_away_goals)

      # update the relevant information
      fpl_fixture.ht_clean_sheet_probability = prediction[:ht_clean_sheet_probability]
      fpl_fixture.at_clean_sheet_probability = prediction[:at_clean_sheet_probability]
      fpl_fixture.ht_possible_goals = prediction[:ht_possible_goals]
      fpl_fixture.at_possible_goals = prediction[:at_possible_goals]
      fpl_fixture.save
    end
  end
end
