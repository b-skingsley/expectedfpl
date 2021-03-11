class PlayersController < ApplicationController
  def edit
    @player = Player.find(params[:id])
    @team = @player.team
    @teamplayers = @team.players.map(&:footballer)
    @collection = Footballer.where(position: @player.footballer.position).where.not(id: @team.players.pluck(:footballer_id))
    @clubs = Club.where(id: @collection.pluck(:club_id))

    # Available Budget -----
    @team = Team.find(params[:team])
    @player = Player.find(params[:id])
    @total_budget = @team.budget + @team.team_value
    @team_value = helpers.price_sum(@team)
    @player_price = @player.footballer.price
    @available_budget = @total_budget - @team_value + @player_price
    
    # ----------------------


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
    case @player.footballer.position
    when 'GK'
      @max_p = (Footballer.gks.first.price) / 10.0
      @min_p = (Footballer.gks.last.price) / 10.0
    when 'DEF'
      @max_p = (Footballer.defs.first.price) / 10.0
      @min_p = (Footballer.defs.last.price) / 10.0
    when 'MID'
      @max_p = (Footballer.mids.first.price) / 10.0
      @min_p = (Footballer.mids.last.price) / 10.0
    else
      @max_p = (Footballer.fwds.first.price) / 10.0
      @min_p = (Footballer.fwds.last.price) / 10.0
    end
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
