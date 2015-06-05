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
    url = "#{DISCOURSE_URL.to_s}/admin/badges.json?api_key=#{API_KEY.to_s}&api_username=#{API_USERNAME.to_s}"
    badges = HTTParty.get(url)
    badge = badges['badges'].select{ |badge| badge['name'] == @badge_name  }.first
    badge['id']
  end

  def assign_badge
    badge_id = get_badge_id
    params = {username: @username, badge_id: badge_id}
    url = "#{DISCOURSE_URL.to_s}/user_badges?api_key=#{API_KEY.to_s}&api_username=#{API_USERNAME.to_s}"
    HTTParty.post(url, body: params)
  end

end