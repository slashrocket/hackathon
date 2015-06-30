class DiscourseAPI
  require 'httparty'
  require 'redcarpet'

  API_KEY = ENV['DISCOURSE_API_KEY']
  API_USERNAME = ENV['DISCOURSE_API_USERNAME']
  DISCOURSE_URL = ENV['DISCOURSE_URL']

  def initialize(username, badge_name, category)
    @username = username
    @badge_name = badge_name
    @category = category
  end

  def user_in_discourse?
    url = "#{DISCOURSE_URL}/users/#{@username}.json"
    response = HTTParty.get(url)
    !response['user'].nil?
  end

  def create_user
    user = User.find_by_username(@username)
    url = "#{DISCOURSE_URL}/users?api_key=#{API_KEY}&api_username=#{API_USERNAME}"
    params = {
      name: user.username,
      username: user.username,
      email: user.email,
      password: SecureRandom.hex,
      active: true
    }
    HTTParty.post(url, body: params)
  end

  def get_badge_id
    url = "#{DISCOURSE_URL}/admin/badges.json?api_key=#{API_KEY}&api_username=#{API_USERNAME}"
    badges = HTTParty.get(url)
    badge = badges['badges'].find { |badge| badge['name'] == @badge_name }
    badge['id']
  end

  def create_topic
    url = "#{DISCOURSE_URL}/posts?api_key=#{API_KEY}&api_username=#{@username}"
    user = User.includes(:entry, team: :entry).find_by_username(@username)
    if user.entry
      entry = user.entry
      post = "##{entry.name}\n  Repository url: #{entry.url}\n  About the project:\n  #{entry.about}\n  "
    elsif user.team.entry
      entry = user.team.entry
      user_list = user.team.users.collect{|u| "@#{u.username}"}.join('/n  ')
      post = "##{entry.name}\n  Repository url: #{entry.url}\n  Team Members:\n  #{user_list}\n  About the project:\n  #{entry.about}\n  "
    end
    
    html = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new(:hard_wrap => true), autolink: true).render(post)
    params = {
      title: entry.name,
      category: @category,
      raw: html
    }
    HTTParty.post(url, body: params)
  end

  def assign_badge
    create_user unless user_in_discourse?
    create_topic
    badge_id = get_badge_id
    params = { username: @username, badge_id: badge_id }
    url = "#{DISCOURSE_URL}/user_badges?api_key=#{API_KEY}&api_username=#{API_USERNAME}"
    HTTParty.post(url, body: params)
  end
end
