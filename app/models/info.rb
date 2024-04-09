class Info < ApplicationRecord
  validates_presence_of %w[name value]

  def self.sync_thresholds!
    riot = RiotApiClient.instance
    gm = find_or_initialize_by(name: :grandmaster_threshold)
    gm.update!(value: riot.rank_threshold(rank: 'grandmaster'))
    chall = find_or_initialize_by(name: :challenger_threshold)
    chall.update!(value: riot.rank_threshold(rank: 'challenger'))
  end

  def self.grandmaster_threshold
    find_by(name: :grandmaster_threshold) || new(name: :grandmaster_threshold, value: "Unbekannt")
  end

  def self.challenger_threshold
    find_by(name: :challenger_threshold) || new(name: :grandmaster_threshold, value: "Unbekannt")
  end
end
