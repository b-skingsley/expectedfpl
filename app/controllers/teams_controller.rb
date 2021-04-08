class TeamsController < ApplicationController
  def show
    #define the players in the team and who's on the bench and which bench position
    @team = Team.includes(players: :footballer).find(params[:id])
    @starters = @team.players.where(starter: true)
    @bench = @team.players.where(starter: false)
    @gk = @bench.find_by(bench_pos: 0)
    @firstsub = @bench.find_by(bench_pos: 1)
    @secondsub = @bench.find_by(bench_pos: 2)
    @thirdsub = @bench.find_by(bench_pos: 3)

    # Establish value of team and the total budget available to the manager
    @team_value = helpers.price_sum(@team)
    @total_budget = @team.budget + @team.team_value
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)
    @team.user = current_or_guest_user
    # Pulling the data from the Fantasy Premier League API for the team's stats
    @data = helpers.teamscrape(params[:team][:fpl_team_id])

    # saving the important team info to the team instance
    @team.budget = @data[:budget]
    @team.team_value = @data[:team_value]
    @team.summary_overall_points = @data[:points]
    @team.summary_overall_rank = @data[:rank]

    # defining the footballers that will make up the players in this team
    @footballers = @data[:players]

    # Initialize each footballer as a player in this specific team and define whether a bench player
    if @team.save
      @footballers.each do |footballer|
        if footballer[1] < 12
          Player.create!(team: @team, footballer: footballer[0], starter: true)
        elsif footballer[1] == 12
          Player.create!(team: @team, footballer: footballer[0], starter: false, bench_pos: 0)
        elsif footballer[1] == 13
          Player.create!(team: @team, footballer: footballer[0], starter: false, bench_pos: 1)
        elsif footballer[1] == 14
          Player.create!(team: @team, footballer: footballer[0], starter: false, bench_pos: 2)
        else
          Player.create!(team: @team, footballer: footballer[0], starter: false, bench_pos: 3)
        end
      end

      #give message depending on whether user is signed in or not

      if user_signed_in?
        redirect_to team_path(@team), notice: 'Team successfully created'
      else
        redirect_to team_path(@team), alert: 'You are taking a tour as a guest. Data will be deleted once the session has ended.'
      end
    else
      render :new
    end
  end

  # switch is the mechanism by which players are moved in the team between the starting team and the bench or between positions on the bench
  def switch
    @team = Team.find(params[:id])
    # We save the parameters from the two players that were clicked on in the team view
    @player1paras = params[:team][:player1].split(",")
    @player2paras = params[:team][:player2].split(",")
    # find the players in our team that were clicked on
    @player1 = Player.find_by(footballer_id: @player1paras[0], team: @team)
    @player2 = Player.find_by(footballer_id: @player2paras[0], team: @team)
    # The parameters returned will be the footballer id and if a bench player the bench position. So if the length is > 1 then the player was on the bench
    # In this case player 1 was on the bench, player 2 in the team, so we switch their starter variable, give player 1's previous bench pos to player 2 and set player 1's position to nil
    if @player1paras.length > 1 && @player2paras.length == 1
      @position1 = @player1paras[1].strip.to_i
      @position2 = nil
      @player1.starter = !@player1.starter
      @player2.starter = !@player2.starter
    end
    # Same case as before but switched
    if @player2paras.length > 1 && @player1paras.length == 1
      @position2 = @player2paras[1].strip.to_i
      @position1 = nil
      @player1.starter = !@player1.starter
      @player2.starter = !@player2.starter
    end
    # In this case both players are bench players and this is a switch of bench position so we just switch those
    if @player2paras.length > 1 && @player1paras.length > 1
      @position2 = @player2paras[1].strip.to_i
      @position1 = @player1paras[1].strip.to_i
    end
    # Save the bench position to the player in our db
    @player1.bench_pos = @position2
    @player2.bench_pos = @position1
    # If both players saved successfully redirect to team page
    if @player1.save && @player2.save
      redirect_to team_path(@team)
    else
      render :show
    end
  end

  # Controller for retrieving player's league from the Premier League API
  def retrieve
    @team = Team.find(params[:id])
    # Call helper to retrieve league data
    @our_leagues = helpers.leagues(@team.fpl_team_id)
    # Intitialize each league and the teamentry instance of the team in that league
    @our_leagues.each do |league|
      League.create!(name: league[0], fpl_league_id: league[1])
      TeamEntry.create!(team: @team, league: League.find_by(fpl_league_id: league[1]))
    end
    redirect_to team_leagues_path(@team), notice: 'Leagues successfully created'
  end

  # Controller for finalize page with final squad information and transfers to do
  def finalize
    # save the relevant players and their positions as instance variables for the team display
    @team = Team.find(params[:id])
    @starters = @team.players.where(starter: true)
    @bench = @team.players.where(starter: false)
    @gk = @bench.find_by(bench_pos: 0)
    @firstsub = @bench.find_by(bench_pos: 1)
    @secondsub = @bench.find_by(bench_pos: 2)
    @thirdsub = @bench.find_by(bench_pos: 3)
    # Retrieve all transfers made for that team in the current gameweek
    @transfers = Transfer.where(team: @team, gw: helpers.next_gameweek_no)
  end

  def footballer
    @footballer = Footballer.find(params[:footballer_id])
    render partial: "teams/modal"
  end


  private

  def team_params
    params.require(:team).permit(:name, :fpl_team_id)
  end
end
