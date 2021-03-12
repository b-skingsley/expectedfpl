class TeamsController < ApplicationController
  def show
    @team = Team.includes(players: :footballer).find(params[:id])
    @starters = @team.players.where(starter: true)
    @bench = @team.players.where(starter: false)
    @gk = @bench.find_by(bench_pos: 0)
    @firstsub = @bench.find_by(bench_pos: 1)
    @secondsub = @bench.find_by(bench_pos: 2)
    @thirdsub = @bench.find_by(bench_pos: 3)
    @team_value = helpers.price_sum(@team)
    @total_budget = @team.budget + @team.team_value
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)
    @team.user = current_user
    @data = helpers.teamscrape(params[:team][:fpl_team_id])
    @team.budget = @data[:budget]
    @team.team_value = @data[:team_value]
    @team.summary_overall_points = @data[:points]
    @team.summary_overall_rank = @data[:rank]
    @footballers = @data[:players]
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
      redirect_to team_path(@team), notice: 'Team successfully created'
    else
      render :new
    end
  end

  def switch
    @team = Team.find(params[:id])
    @player1paras = params[:team][:player1].split(",")
    @player2paras = params[:team][:player2].split(",")
    @player1 = Player.find_by(footballer_id: @player1paras[0], team: @team)
    @player2 = Player.find_by(footballer_id: @player2paras[0], team: @team)
    if @player1paras.length > 1 && @player2paras.length == 1
      @position1 = @player1paras[1].strip.to_i
      @position2 = nil
      @player1.starter = !@player1.starter
      @player2.starter = !@player2.starter
    end
    if @player2paras.length > 1 && @player1paras.length == 1
      @position2 = @player2paras[1].strip.to_i
      @position1 = nil
      @player1.starter = !@player1.starter
      @player2.starter = !@player2.starter
    end
    if @player2paras.length > 1 && @player1paras.length > 1
      @position2 = @player2paras[1].strip.to_i
      @position1 = @player1paras[1].strip.to_i
    end

    @player1.bench_pos = @position2
    @player2.bench_pos = @position1
    if @player1.save && @player2.save
      redirect_to team_path(@team)
    else
      render :show
    end
  end

  def retrieve
    @team = Team.find(params[:id])
    @our_leagues = helpers.leagues(@team.fpl_team_id)
    @our_leagues.each do |league|
      League.create!(name: league[0], fpl_league_id: league[1])
      TeamEntry.create!(team: @team, league: League.find_by(fpl_league_id: league[1]))
    end
    redirect_to team_leagues_path(@team), notice: 'Leagues successfully created'
  end

  def finalize
    @team = Team.find(params[:id])
    @starters = @team.players.where(starter: true)
    @bench = @team.players.where(starter: false)
    @gk = @bench.find_by(bench_pos: 0)
    @firstsub = @bench.find_by(bench_pos: 1)
    @secondsub = @bench.find_by(bench_pos: 2)
    @thirdsub = @bench.find_by(bench_pos: 3)
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
