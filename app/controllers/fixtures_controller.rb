class FixturesController < ApplicationController
  # skip_before_action :authenticate_user!, only: [ :index, :show ]
  # before_action :set_fixture, only: [:show]

  def index
    if params[:query].present?
      @fixtures = Fixture.global_search(params[:query])
    else
      @fixtures = Fixture.all
    end


    if params[:status] == "past"
      @fixtures = @fixtures.results.reverse
    elsif params[:status] == "current"
      @fixtures = @fixtures.gameweek
    elsif params[:status] == "future"
      @fixtures = @fixtures.future_fixtures
    else
      @fixtures = @fixtures.future_fixtures
    end
    @clubs = Club.all
  end


  # def show
  # end

  private

  def strong_params
    params.permit(:search)
  end

  # def set_fixture
  #   @fixture = Fixture.find(params[:id])
  # end
end
