class DiscourseUpdateWorker
  include Sidekiq::Worker
  def perform(team_id, badge_name, category)
    DiscourseAPI.new(team_id, badge_name, category).member_added
  end
end
