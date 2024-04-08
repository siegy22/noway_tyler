class Entry < ApplicationRecord
  belongs_to :account

  validates_presence_of %i[account_id]
end
