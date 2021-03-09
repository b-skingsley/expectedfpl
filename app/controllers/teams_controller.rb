class TeamsController < ApplicationController
  def show
    @team = Team.find(params[:id])
    @starters = @team.players.where(starter: true)
    @bench = @team.players.where(starter: false)
    @gk = @bench.find_by(bench_pos: 0)
    @firstsub = @bench.find_by(bench_pos: 1)
    @secondsub = @bench.find_by(bench_pos: 2)
    @thirdsub = @bench.find_by(bench_pos: 3)
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)
    @team.user = current_user
    if @team.save
      redirect_to team_path(@team), notice: 'Team successfully created'
    else
      render :new
    end
  end

  def edit
    @team = Team.find(params[:id])
  end

  def update
    @team = Team.find(params[:id])
    @team.update(team_params)

    redirect_to team_path(@team)
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

  private

  def team_params
    params.require(:team).permit(:name, :fpl_team_id)
  end
end
