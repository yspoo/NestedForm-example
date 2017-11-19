class Team < ApplicationRecord
  has_many  :users

  def team_name=(name)
    # find that team by name
  end
  
end
