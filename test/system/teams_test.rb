require "application_system_test_case"

class TeamsTest < ApplicationSystemTestCase
  def setup
    Rails.application.load_seed
    login_as User.first
  end

  test "creating a team" do
    visit "/teams/new"
    # save_and_open_screenshot

    fill_in "team_name", with: "Barry's Team"
    fill_in "team_fpl_team_id", with: "38281"
    # save_and_open_screenshot

    click_on 'Create Team'
    # save_and_open_screenshot

    assert_text "Barry's Team"
    assert_selector ".player-content", count: 15
  end

  test "opening a player info" do
    visit "/teams/#{Team.last.id}"

    find_all('.player-info').first.click

    assert_selector ".expanded-more-stats"
    click_on 'More Info'

    assert_selector ".list-group"
    assert_text "Chance of playing next game"
  end

end
