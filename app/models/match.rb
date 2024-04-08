class Match < ApplicationRecord
  INDIVIDUAL_POSITION_MAPPING = {
    "TOP" => "top",
    "JUNGLE" => "jungle",
    "MIDDLE" => "mid",
    "BOTTOM" => "adc",
    "UTILITY" => "supp",
  }

  belongs_to :account
  scope :ordered, -> { order(started_at: :desc) }
end
