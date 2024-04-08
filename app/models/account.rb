class Account < ApplicationRecord
  validates_presence_of %i[role riot_id summoner_id puuid profile_icon_id summoner_level]
  has_many :entries

  def opgg_url
    "https://www.op.gg/summoners/euw/#{riot_id.tr('#', '-')}"
  end
end
