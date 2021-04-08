class PlayersController < ApplicationController
  # This is the functionality for transferring a player in your team
  def edit
    @player = Player.find(params[:id])
    @team = @player.team
    # Retrieve the footballers already on the team
    @teamplayers = @team.players.map(&:footballer)
    # Save a collection of footballers that play in the same position as the player to be transferred and that aren't already in the team
    @collection = Footballer.where(position: @player.footballer.position).where.not(id: @team.players.pluck(:footballer_id))
    # save the clubs of footballers in the collection
    @clubs = Club.where(id: @collection.pluck(:club_id))

    # price (float) instance variables for use in the view (prices received from API are in integer form such as 112 for £11.2)
    # first a query to reorder the applicable players by price to ascertain max/mins depending on position
    players_by_price = @collection.reorder('price DESC')

    @max_p = (players_by_price.first.price) / 10.0
    @min_p = (players_by_price.last.price) / 10.0

    # Available Budget based on team value and leftover budget from api
    @total_budget = @team.budget + @team.team_value
    @team_value = helpers.price_sum(@team)
    @player_price = @player.footballer.price
    # Define available budget for this transfer taking into account price of player we're transferring out
    @available_budget = @total_budget - @team_value + @player_price

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
  end

  # Saving the player switch to our db once transfer is confirmed
  def update
    @player = Player.find(params[:id])
    @team = @player.team

    # Find gameweek to save transfer
    @gw = helpers.next_gameweek_no
    player_in = Footballer.find(params[:in])

    # save record of the transfer
    @transfer = Transfer.new(team: @team, player_in: player_in, player_out: @player.footballer, gw: @gw)
    @transfer.save

    # Update the footballer of the player in the team. This way the player maintains the same starter and bench pos status as the player they're replacing
    if @player.update(footballer: Footballer.find(params[:in]))
      redirect_to team_path(@team), notice: "#{player_in.web_name} succesfully transferred in"
    else
      render :edit
    end
  end
end
