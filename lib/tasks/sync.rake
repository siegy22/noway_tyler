namespace :sync do
  desc "Sync matches and entries to database"
  task riot: [:environment] do
    loop do
      Account.all.each(&:sync_entry!)
      sleep 30
    end
  end
end
