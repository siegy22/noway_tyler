namespace :sync do
  desc "Sync current rank statistics"
  task current_ranks: [:environment] do
    loop do
      Account.find_each(&:sync_entry!)
      sleep 30
    end
  end

  desc "Sync OpenAI predictions"
  task openai: [:environment] do
    Account.find_each(&:sync_ai_prediction!)
  end

  desc "Sync Grandmaster/Challenger thresholds"
  task thresholds: [:environment] do
    Info.sync_thresholds!
  end
end
