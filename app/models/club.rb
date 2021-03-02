class Club < ApplicationRecord
  has_many :footballers
  has_many :fixtures

  validates :name, :short_name, :form, presence: true
  validates :form, length: { maximum: 5 }
  validates :short_name, length: { is: 3 }

  before_save :uppercase_short_name
  before_save :uppercase_form

  def uppercase_short_name
    short_name.upcase!
  end

  def uppercase_form
    form.upcase!
  end
end
