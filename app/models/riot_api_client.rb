class RiotApiClient
  include Singleton
  include HTTParty
  RIOT_EUROPE_API_URL = 'https://europe.api.riotgames.com'.freeze
  RIOT_EUW1_API_URL = 'https://euw1.api.riotgames.com'.freeze
  raise_on (400..504).to_a

  headers 'X-Riot-Token' => Rails.application.credentials.api_key

  def account_by_riot_id(riot_id)
    name, tag_line = riot_id.split('#')
    self.class.get("#{RIOT_EUROPE_API_URL}/riot/account/v1/accounts/by-riot-id/#{name}/#{tag_line}")
  end

  def summoner_by_puuid(puuid)
    self.class.get("#{RIOT_EUW1_API_URL}/lol/summoner/v4/summoners/by-puuid/#{puuid}")
  end

  def entry_by_summoner(summoner_id)
    res = self.class.get("#{RIOT_EUW1_API_URL}/lol/league/v4/entries/by-summoner/#{summoner_id}")
    res.find { |i| i['queueType'] == 'RANKED_SOLO_5x5' }
  end

  def match_ids(puuid, since, queue: 420)
    start = 0
    responses = []
    loop do
      response = self.class.get(
        "#{RIOT_EUROPE_API_URL}/lol/match/v5/matches/by-puuid/#{puuid}/ids",
        query: {
          count: 100,
          queue: queue,
          startTime: since.to_i,
          start: start
        }
      )

      break if response.count.zero?

      responses.prepend(response)
      start += response.count
    end

    responses.flatten
  end

  def match(id)
    self.class.get("#{RIOT_EUROPE_API_URL}/lol/match/v5/matches/#{id}")
  end

  def matches(puuid, since:)
    ids = match_ids(puuid, since)
    ids.map { |id| match(id) }
  end
end
