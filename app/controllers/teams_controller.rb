class TeamsController < ApplicationController
  def show
    @team = Team.find(params[:id])
    @starters = @team.players.where(starter: true)
    @bench = @team.players.where(starter: false)
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
    @player1 = Player.find_by(footballer_id: params[:team][:player1], team: @team)
    @player2 = Player.find_by(footballer_id: params[:team][:player2], team: @team)
    @player1.starter = !@player1.starter
    @player2.starter = !@player2.starter
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
