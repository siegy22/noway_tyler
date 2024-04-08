riot = RiotApiClient.instance

[
  { riot_id: 'Tolkin4U#T06', role: 'top' },
  { riot_id: 'Noway4U#T06', role: 'mid' },
  { riot_id: 'Broeki4U#T06', role: 'adc' }
].each do |data|
  riot_account = riot.account_by_riot_id(data[:riot_id])
  summoner = riot.summoner_by_puuid(riot_account['puuid'])

  account = Account.find_or_initialize_by(puuid: riot_account['puuid'])
  account.update!(
    role: data[:role],
    riot_id: data[:riot_id],
    summoner_id: summoner['id'],
    puuid: summoner['puuid'],
    profile_icon_id: summoner['profileIconId'],
    summoner_level: summoner['summonerLevel'],
  )
  account.sync_entry!
end
