class Transfer < ApplicationRecord
  belongs_to :team
  belongs_to :player_in, :class_name => "Footballer", :foreign_key => :player_in_id
  belongs_to :player_out, :class_name => "Footballer", :foreign_key => :player_out_id
end
