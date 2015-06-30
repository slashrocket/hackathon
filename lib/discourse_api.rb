class DiscourseAPI
  require 'httparty'
  require 'redcarpet'

  API_KEY = ENV['DISCOURSE_API_KEY']
  API_USERNAME = ENV['DISCOURSE_API_USERNAME']
  DISCOURSE_URL = ENV['DISCOURSE_URL']

  def initialize(team_id, badge_name, category)
    @team_id = team_id
    @badge_name = badge_name
    @category = category
  end

  def user_in_discourse?(user)
    url = "#{DISCOURSE_URL}/users/#{user.username}.json"
    response = HTTParty.get(url)
    !response['user'].nil?
  end

  def create_user(user)
    user = User.find_by_username(user.username)
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

  def assign_badge(user)
    create_user(user) unless user_in_discourse?(user)
    badge_id = get_badge_id
    params = { username: user.username, badge_id: badge_id }
    url = "#{DISCOURSE_URL}/user_badges?api_key=#{API_KEY}&api_username=#{API_USERNAME}"
    HTTParty.post(url, body: params)
  end

  def create_topic(team)
    owner = team.owner
    url = "#{DISCOURSE_URL}/posts?api_key=#{API_KEY}&api_username=#{owner.username}"
    entry = team.entry
    user_list = team.users.collect{|u| "@#{u.username}"}.join('/n  ')
    post = "##{entry.name}\n  Project url: #{entry.url}\n  Team Members:\n  #{user_list}\n  About the project:\n  #{entry.about}\n  "
    html = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new(:hard_wrap => true), autolink: true).render(post)
    params = {
      title: entry.name,
      category: @category,
      raw: html
    }
    HTTParty.post(url, body: params)
  end

  def post_entry
    team = Team.includes(:owner, team_members:[:user]).find(@team_id)
    team.users.each do |user|
      assign_badge(user)
    end
    create_topic(team)
  end

  def update_topic
    
  end
end
