class Entry < ApplicationRecord
  RANKLESS_TIERS = %w[master grandmaster challenger].freeze
  belongs_to :account

  validates_presence_of %i[account_id]

  scope :ordered, -> { order(created_at: :desc) }

  def winrate
    (wins / (wins.to_f + losses.to_f) * 100).round
  end

  def lossrate
    (losses / (wins.to_f + losses.to_f) * 100).round
  end

  def rank_label
    return tier.capitalize if RANKLESS_TIERS.include?(tier.downcase)

    "#{tier.capitalize} #{rank}"
  end

  # Creates point system across ranks, only respects Diamond and up.
  def total_points
    return 0 unless (RANKLESS_TIERS + ["diamond"]).include?(tier.downcase)
    return 400 + league_points if RANKLESS_TIERS.include?(tier.downcase)

    {
      'IV' => 0,
      'III' => 1,
      'II' => 2,
      'I' => 3,
    }[rank] * 100 + league_points
  end
end
