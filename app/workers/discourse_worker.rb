class DiscourseWorker
  include Sidekiq::Worker
  def perform(team_id, badge_name, category)
    DiscourseAPI.new(team_id, badge_name, category).post_entry
  end
end
