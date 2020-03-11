# slack_api_wrapper.rb
require "httparty"

module SlackApiWrapper

  class SlackApiError < StandardError; end

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

    unless response.code == 200 && response.parsed_response["ok"]
      raise SlackApiError, "Error when posting #{message} to #{channel_name}, error: #{response.parsed_response["error"]}"
    end

    return true
  end
end
