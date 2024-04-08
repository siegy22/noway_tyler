namespace :sync do
  desc "Sync matches and entries to database"
  task riot: [:environment] do
    loop do
      Account.all.each(&:sync_entry!)
      sleep 30
    end
  end

  desc "Sync OpenAI predictions"
  task openai: [:environment] do
    Account.all.each(&:sync_ai_prediction!)
  end
end
