class PlayersController < ApplicationController
  def edit
    @player = Player.find(params[:id])
    @team = @player.team
    @teamplayers = @team.players.map(&:footballer)
    @collection = Footballer.where(position: @player.footballer.position) - @teamplayers
  end

  def update
    @player = Player.find(params[:id])
    @team = @player.team
    @transfer = Transfer.new(team: @team, player_in: Footballer.find(params[:in]), player_out: @player.footballer)
    @transfer.save
    if @player.update(footballer: Footballer.find(params[:in]))
      redirect_to team_path(@team)
    else
      render :edit
    end
  end
end
