class Club < ApplicationRecord
  has_many :footballers
  has_many :fixtures
end
