class PlayersController < ApplicationController
  def edit
    @player = Player.find(params[:id])
    @team = @player.team
    @teamplayers = @team.players.map(&:footballer)
    @collection = Footballer.where(position: @player.footballer.position).where.not(id: @team.players.pluck(:footballer_id))
    @clubs = Club.where(id: @collection.pluck(:club_id))

    if params[:query].present?
      @collection = @collection.search_by_first_and_last_name(params[:query])
    elsif params[:filter_by_club].present? || params[:filter_by_max_price].present?
      club_id = @clubs.find_by(name: params[:filter_by_club]).id if params[:filter_by_club].present?
      max_p = (params[:filter_by_max_price].to_f * 10).to_i
      if params[:filter_by_club].present? && params[:filter_by_max_price].present?
        @collection = @collection.where(club_id: club_id).where("price <= ?", max_p)
      elsif params[:filter_by_club].present?
        @collection = @collection.where(club_id: club_id)
      else
        @collection = @collection.where("price <= ?", max_p)
      end
    end

    # price (float) instance variables for use in the view
    # first a query to reorder the applicable players by price to ascertain max/mins depending on position
    players_by_price = @collection.reorder('price DESC')

    @max_p = (players_by_price.first.price) / 10.0
    @min_p = (players_by_price.last.price) / 10.0

  end

  def update
    @player = Player.find(params[:id])
    @team = @player.team
    @gw = helpers.next_gameweek_no
    @transfer = Transfer.new(team: @team, player_in: Footballer.find(params[:in]), player_out: @player.footballer, gw: @gw)
    @transfer.save
    if @player.update(footballer: Footballer.find(params[:in]))
      redirect_to team_path(@team)
    else
      render :edit
    end
  end
end
