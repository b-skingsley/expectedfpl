class TeamsController < ApplicationController
  def show
    @team = Team.find(params[:id])
    @starters = @team.players.where(starter: true)
    @bench = @team.players.where(starter: false)
    @firstsub = @bench[1].footballer
    @secondsub = @bench[2].footballer
    @thirdsub = @bench[3].footballer
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

  private

  def team_params
    params.require(:team).permit(:name, :fpl_team_id)
  end
end
