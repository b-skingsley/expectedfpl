class Club < ApplicationRecord
  has_many :footballers
  has_many :fixtures, dependent: :destroy

  validates :name, :short_name, presence: true
  validates :form, length: { maximum: 5 }
  validates :short_name, length: { is: 3 }

  before_save :uppercase_short_name
  before_save :uppercase_form

  private

  def uppercase_short_name
    self.short_name.upcase!
  end

  def uppercase_form
    self.form.upcase!
  end
end
