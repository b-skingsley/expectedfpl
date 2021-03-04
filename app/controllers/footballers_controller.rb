class FootballersController < ApplicationController
  def index
    @footballers = Footballer.all
    @clubs = Club.all

    if params[:query].present?
      @footballers = @footballers.search_by_first_and_last_name(params[:query])
    elsif params[:filter_by_position].present? || params[:filter_by_club].present? || params[:filter_by_max_price].present?
      position = params[:filter_by_position]
      club_id = @clubs.find_by(name: params[:filter_by_club]).id if params[:filter_by_club].present?
      max_p = params[:filter_by_max_price]
      if params[:filter_by_position].present? && params[:filter_by_club].present? && params[:filter_by_max_price].present?
        @footballers = @footballers.where(position: position, club_id: club_id).where("price <= ?", max_p)
      elsif params[:filter_by_position].present? && params[:filter_by_club].present?
        @footballers = @footballers.where(position: position, club_id: club_id)
      elsif params[:filter_by_position].present? && params[:filter_by_max_price].present?
        @footballers = @footballers.where(position: position).where("price <= ?", max_p)
      elsif params[:filter_by_club].present? && params[:filter_by_max_price].present?
        @footballers = @footballers.where(club_id: club_id).where("price <= ?", max_p)
      elsif params[:filter_by_position].present?
        @footballers = @footballers.where(position: position)
      elsif params[:filter_by_club].present?
        @footballers = @footballers.where(club_id: club_id)
      else
        @footballers = @footballers.where("price <= ?", max_p)
      end
    end
    if @footballers.present?
      @max_p = @footballers.first.price
      @min_p = @footballers.last.price
    end
  end

  def show
    @footballer = Footballer.find(params[:id])
  end
end
