class FootballersController < ApplicationController
  def index
    if params[:query].present? || params[:filter_by_position].present? || params[:filter_by_club].present?
      if params[:query].present? && params[:filter_by_position].present? && params[:filter_by_club].present?
        @footballers = Footballer.search_by_first_and_last_name(params[:query])
        club_id = Club.find_by(name: params[:filter_by_club])
        @footballers = @footballers.where(position: params[:filter_by_position], club_id: club_id)
      elsif params[:query].present? && params[:filter_by_position].present?
        @footballers = Footballer.search_by_first_and_last_name(params[:query])
        @footballers = @footballers.where(position: params[:filter_by_position])
      elsif params[:query].present? && params[:filter_by_club].present?
        club_id = Club.find_by(name: params[:filter_by_club])
        @footballers = Footballer.search_by_first_and_last_name(params[:query])
        @footballers = @footballers.where(club_id: club_id)
      elsif params[:filter_by_position].present? && params[:filter_by_club].present?
        club_id = Club.find_by(name: params[:filter_by_club])
        @footballers = Footballer.where(position: params[:filter_by_position], club_id: club_id)
      elsif params[:filter_by_position].present?
        @footballers = Footballer.where(position: params[:filter_by_position])
      elsif params[:filter_by_club].present?
        @footballers = Footballer.where(club_id: club_id)
      else
        @footballers = Footballer.search_by_first_and_last_name(params[:query])
      end
    else
      @footballers = Footballer.all
    end
  end

  def show
    @footballer = Footballer.find(params[:id])
  end
end
