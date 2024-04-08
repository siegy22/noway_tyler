class Account < ApplicationRecord
  validates_presence_of %i[role riot_id summoner_id puuid profile_icon_id summoner_level]
  has_many :entries
  has_many :matches

  def wins
    entries.ordered.first.wins
  end

  def losses
    entries.ordered.first.losses
  end

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

  def role_hitrate
    return 0 if matches.count.zero?

    (matches.where(role: role).count / matches.count.to_f * 100).round
  end

  def role_miss_count
    matches.where.not(role: role).count
  end

  def opgg_url
    "https://www.op.gg/summoners/euw/#{riot_id.tr('#', '-')}"
  end

  def sync_entry!
    riot_entry = RiotApiClient.instance.entry_by_summoner(summoner_id)
    entry = entries.find_or_create_by!(riot_entry.slice('wins', 'losses'))
    entry.update!(rank: riot_entry['rank'], tier: riot_entry['tier'], league_points: riot_entry['leaguePoints'])
  end

  def sync_matches!
    riot_matches = RiotApiClient.instance.matches(puuid, since: matches.ordered.first&.started_at || Time.at(0))
    riot_matches.each do |riot_match|
      match = matches.find_or_initialize_by(riot_id: riot_match['metadata']['matchId'])
      player_data = riot_match["info"]["participants"].find do |participant|
        participant["puuid"] == puuid
      end
      match.update!(
        role: Match::INDIVIDUAL_POSITION_MAPPING[player_data['individualPosition']],
        win: player_data["win"],
        started_at: Time.at(riot_match["info"]["gameCreation"] / 1000)
      )
    end
  end

  def sync_ai_prediction!
    update!(ai_prediction_finish: AI.instance.predict_finish(self))
  end
end
