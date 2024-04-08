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
end
