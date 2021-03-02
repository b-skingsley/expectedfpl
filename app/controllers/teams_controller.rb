class TeamsController < ApplicationController
  def show
    @team = Team.find(params[:id])
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
