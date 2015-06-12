class DiscourseAPI
  require 'HTTParty'

  API_KEY = ENV['DISCOURSE_API_KEY']
  API_USERNAME = ENV['DISCOURSE_API_USERNAME']
  DISCOURSE_URL = ENV['DISCOURSE_URL']

  def initialize(username, badge_name)
    @username = username
    @badge_name = badge_name
  end

  def get_badge_id
    url = "#{DISCOURSE_URL}/admin/badges.json?api_key=#{API_KEY}&api_username=#{API_USERNAME}"
    badges = HTTParty.get(url)
    badge = badges['badges'].find { |badge| badge['name'] == @badge_name }
    badge['id']
  end

  def assign_badge
    badge_id = get_badge_id
    params = { username: @username, badge_id: badge_id }
    url = "#{DISCOURSE_URL}/user_badges?api_key=#{API_KEY}&api_username=#{API_USERNAME}"
    HTTParty.post(url, body: params)
  end
end
