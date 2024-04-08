class Account < ApplicationRecord
  validates_presence_of %i[role riot_id summoner_id puuid profile_icon_id summoner_level]
  has_many :entries

  def winrate
    entries.ordered.first.winrate
  end

  def lossrate
    entries.ordered.first.lossrate
  end

  def rank_label
    entries.ordered.first.rank_label
  end

  def tier
    entries.ordered.first.tier
  end

  def lp
    entries.ordered.first.league_points
  end

  def opgg_url
    "https://www.op.gg/summoners/euw/#{riot_id.tr('#', '-')}"
  end

  def sync_entry!
    riot_entry = RiotApiClient.instance.entry_by_summoner(summoner_id)
    entry = entries.find_or_create_by!(riot_entry.slice('wins', 'losses'))
    entry.update!(rank: riot_entry['rank'], tier: riot_entry['tier'], league_points: riot_entry['leaguePoints'])
  end
end
