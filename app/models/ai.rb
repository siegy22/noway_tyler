class AI
  include Singleton

  def initialize
    @client = OpenAI::Client.new(access_token: Rails.application.credentials.openai_access_token)
  end

  def predict_finish(account)
    result = @client.chat(
      parameters: {
        model: "gpt-4",
        temperature: 0.8,
        messages: [
          {
            "role": "system",
            "content": "Noway4u the german league of legends streamer is attempting a challenge to reach Challenger on three roles: Top, mid and ADC. For this he has 3 different accounts: Tolkin4U#T06 (top), Noway4U#T06 (mid) and Broeki4U#T06 (adc). The challenge started on 2024-03-20. A rough calculation to hit challenger with a fresh account would take at least 100 games. Keep in mind he will play only a third of his usual time (about 6 hours per day) on one of the given accounts. The winrate will decline on the higher ranks, as he will start to play in his own elo, respect this in your prediction. \n\nYou are a prediction bot to predict when a given account will reach challenger on what date. For this you will receive the following information:\n- Account\n- Winrate in %\n- Total wins\n- Total losses\n- Current rank with LP\n- Date of request\n\nBe very conservative with your guess, not optimistic.\n\nFor an answer, give me an ISO 8601 date, no explanation. Just the date."
          },
          {
            "role": "user",
            "content": <<~PROMPT
Account: #{account.riot_id} (#{account.role})
Winrate: #{account.role}
Total Wins: #{account.wins}
Total Losses: #{account.losses}
Current Rank: #{account.rank_label} (#{account.lp}LP)
Date of Request: #{Date.today}
Average Game Duration: 50 Minutes
Role-Specific Performance: #{account.ai_role_specific_performance}
Recent Trend in Performance: 60% winrate over the last 20 games
Champion Pool Focus: Playing a diverse pool of champions
External Factors: Doing winchallenges about once a week. Also having one off day per week.
PROMPT
          }
        ]
      }
    )
    Date.parse(result["choices"].first["message"]["content"])
  end
end
