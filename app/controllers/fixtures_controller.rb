class FixturesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show ]
  # before_action :set_fixture, only: [:show]

  def index
    @fixtures = get_fixtures()
  end
  
  # def show
  # end
  
  private

  # def set_fixture
  #   @fixture = Fixture.find(params[:id])
  # end
end
