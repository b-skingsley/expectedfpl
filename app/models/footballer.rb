class Footballer < ApplicationRecord
  belongs_to :club
  has_many :players
  has_many :odds

  default_scope { order(total_points: :desc) }

  validates :first_name, :last_name, :position, :price, :fplid, presence: true
  validates :position, inclusion: { in: %w(GK DEF MID FWD UNKNOWN gk def mid fwd) }
  validates :price, numericality: { greater_than: 30, less_than: 150 }
  validates :fplid, uniqueness: true

  scope :fwds, -> { where(position: "FWD") }
  scope :mids, -> { where(position: "MID") }
  scope :defs, -> { where(position: "DEF") }
  scope :gks, -> { where(position: "GK") }
  scope :unknowns, -> { where(position: "UNKNOWN") }

  include PgSearch::Model
  pg_search_scope :search_by_first_and_last_name,
    against: [ :first_name, :last_name ],
    using: {
      tsearch: { prefix: true }
    }

  include AlgoliaSearch
  algoliasearch do
    attributes :first_name, :last_name
    attribute :full_name
    searchableAttributes ['unordered(last_name)', 'unordered(first_name)']
  end

  def full_name
    "#{first_name} #{last_name}"
  end
  
end
