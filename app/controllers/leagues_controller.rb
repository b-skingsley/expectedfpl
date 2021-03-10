class LeaguesController < ApplicationController
  def show
    @league = League.find(params[:id])
  end

  def index
    @team = Team.find(params[:team_id])
    # @leagues = League.all
    @leagues = League.includes(team_entries: :team).where(team_entries: {team: @team})
  end
end
