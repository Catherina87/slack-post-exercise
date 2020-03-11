# slack_api_wrapper.rb
require "httparty"

module SlackApiWrapper
  POST_URL = "https://slack.com/api/chat.postMessage"
  API_KEY = ENV["SLACK_TOKEN"]

  def self.send_msg(message, channel_name)
    response = HTTParty.post(POST_URL, {
      headers: { 'Content-Type' => 'application/x-www-form-urlencoded' },
      body: {
        token: API_KEY,
        channel: channel_name,
        text: message
      }
    })

    return response.code == 200 && response.parsed_response["ok"]
  end
end
