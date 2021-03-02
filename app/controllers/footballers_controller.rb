class FootballersController < ApplicationController
  def index
    @footballers = Footballer.all
  end

  def show
    @footballer = Footballer.find(params[:id])
  end
end
