class DiscourseWorder
  include Sidekiq::Worker
  def perform(username, badge_name, category)
    DiscourseAPI.new(username, badge_name, category).assign_badge
  end
end