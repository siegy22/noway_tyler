class Account < ApplicationRecord
  validates_presence_of %i[role riot_id summoner_id puuid profile_icon_id summoner_level]
end
