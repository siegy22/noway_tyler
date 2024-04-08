class Account < ApplicationRecord
  validates_presence_of %i[role riot_id summoner_id puuid profile_icon_id summoner_level]
  has_many :entries

  def opgg_url
    "https://www.op.gg/summoners/euw/#{riot_id.tr('#', '-')}"
  end

  def sync_entry!
    riot_entry = RiotApiClient.instance.entry_by_summoner(summoner_id)
    entry = entries.find_or_create_by!(riot_entry.slice('wins', 'losses'))
    entry.update!(rank: riot_entry['rank'], tier: riot_entry['tier'], league_points: riot_entry['leaguePoints'])
  end
end
