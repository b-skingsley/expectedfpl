class Fixture < ApplicationRecord
  belongs_to :home_team, :class_name => "Club", :foreign_key => :home_team_id
  belongs_to :away_team, :class_name => "Club", :foreign_key => :away_team_id
  has_many :odds
  has_many :away_footballers, through: :away_team, source: :footballers
  has_many :home_footballers, through: :home_team, source: :footballers
  # PG Search
  include PgSearch::Model
  pg_search_scope :global_search,
    associated_against: {
      home_team: [ :name ],
      away_team: [ :name ],
      away_footballers: [ :first_name, :last_name],
      home_footballers: [ :first_name, :last_name]
    },
    using: {
      tsearch: { prefix: true }
    }

    scope :results, -> { where("kickoff < ?", DateTime.now()) }
    scope :gameweek, -> { where("kickoff > ?", DateTime.now()).where("kickoff < ?", 1.week.from_now) }
    scope :future_fixtures, -> { where("kickoff > ?", DateTime.now()) }


  # validates :kickoff, :gameweek, presence: true
  validates :gameweek, numericality: { greater_than: 0, less_than: 39 }
  validates :h_score, :a_score, numericality: { greater_than_or_equal_to: 0 }
end
