class Footballer < ApplicationRecord
  belongs_to :club
  has_many :players
  has_many :odds

  validates :first_name, :last_name, :position, :price, presence: true
  validates :position, inclusion: { in: %w(GK DEF MID FWD gk def mid fwd) }
  validates :price, numericality: { greater_than: 30, less_than: 150 }

  before_save :uppercase_position

  scope :fwds, -> { where(position: "FWD") }
  scope :mids, -> { where(position: "MID") }
  scope :defs, -> { where(position: "DEF") }
  scope :gks, -> { where(position: "GK") }

  def uppercase_position
    position.upcase!
  end
end
